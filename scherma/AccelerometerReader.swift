//
//  AccelerometerReader.swift
//  scherma
//
//  Created by Roberto Della Corte on 11/05/24.
//
import SwiftUI
import Foundation
import CoreMotion
import UIKit
import AVFoundation


struct AccelerometerReader: View {
    
    let motionManager = CMMotionManager()
    @State var audioPlayer : AVAudioPlayer!
    @State var count = 0
    
    //variabile per verifcare se si è o meno in posizione di difesa
    @State private var isDefending = false
    @State private var maxTiltAngleDuringDefense: Double = 0.0
    @State private var showMessage = false
    @Binding   var isSoundOn :Bool
    @Binding var soundFirst : String
   
    
    
    
    var body: some View {
        VStack {
            if showMessage {
                Text("Sei uscito dalla posizione di difesa")
                    .foregroundColor(.red)
            }
            Text("") // Puoi lasciare vuoto poiché non vogliamo visualizzare nulla
                .onAppear {
                    startAccelerometerUpdates()
                    startMotionUpdates()
                }
        }
    }
    
    
    func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1
            motionManager.startAccelerometerUpdates(to: .main) { (data, error) in
                guard let acceleration = data?.acceleration else {
                    print("Errore nel rilevamento dell'accelerazione: \(error?.localizedDescription ?? "Errore sconosciuto")")
                    return
                }
                
                // Controlla se il telefono è in posizione di difesa e disabilita l'attacco se necessario
                if isDefending {
                    return // Esci dalla funzione senza eseguire l'attacco
                }
                
                
                                
                // Effettua l'attacco se non si è in posizione di difesa e si rileva un affondo o un taglio
               else  if acceleration.y > 1.5 && abs(acceleration.x) < 1 {
                    print("ATTACCO: AFFONDO")
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred() // Esegui la vibrazione quando viene eseguito l'affondo
                    return
                }
                
               else if acceleration.x > 1  {
                    print("ATTACCO: TAGLIO")
                    print(isSoundOn)
                    if isSoundOn {
                        playSound(sound: soundFirst)}
                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred() // Esegui la vibrazione quando viene eseguito l'affondo
                    return
                }
                
             else   if acceleration.z > 1.5 {
                    print("ATTACCO: FENDENTE")
                }
                
                
              else  if acceleration.y < -1.5 && count < 1{
                    if isSoundOn{
                        playSound(sound: "sword-slash")}
                    count += 1
                }
                

            }
        } else {
            print("L'accelerometro non è disponibile.")
        }
    }
    
    
    func startMotionUpdates() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            
            motionManager.startDeviceMotionUpdates(to: .main) { (data, error) in
                guard let attitude = data?.attitude else {
                    print("Errore nel rilevamento dell'atteggiamento: \(error?.localizedDescription ?? "Errore sconosciuto")")
                    return
                }
                
                handleDefenseLogic(attitude: attitude)
            }
        } else {
            print("Il motion manager non è disponibile")
        }
    }
    
    func handleDefenseLogic(attitude: CMAttitude) {
        let defenseActivationThreshold: Double = 1.25 // Soglia di inclinazione (in radianti) per attivare la difesa permanente
        let tiltAngle = attitude.pitch // Angolo di inclinazione rispetto all'asse desiderato
        
        if isDefending {
            // Se il telefono è in posizione di difesa permanente, aggiorna l'angolo massimo di inclinazione
            if tiltAngle > maxTiltAngleDuringDefense {
                maxTiltAngleDuringDefense = tiltAngle
            }
        }
        
        
        // Verifica se il telefono è in posizione di difesa permanente
        if abs(tiltAngle) > defenseActivationThreshold {
            isDefending = true
            print("Sono in posizione di difesa permanente!")
        } else {
            // Disattiva la difesa permanente quando il telefono è inclinato oltre la soglia
            isDefending = false
            print("Uscito dalla posizione di difesa!")
        }
    }
    
    func stopAccelerometerUpdates() {
        if motionManager.isAccelerometerActive {
            motionManager.stopAccelerometerUpdates()
            print("Aggiornamenti dell'accelerometro fermati.")
        }
    }
    
    func stopMotionUpdates() {
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
            print("Aggiornamenti del motion manager fermati.")
        }
    }
    
    func playSound(sound: String){
        let url = Bundle.main.url(forResource: sound, withExtension: "mp3")
        audioPlayer = try! AVAudioPlayer(contentsOf: url!)
        audioPlayer!.play()
    }
    
}

