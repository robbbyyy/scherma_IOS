//
//  AccelerometerReader.swift
//  scherma
//
//  Created by Roberto Della Corte on 11/05/24.
//
import SwiftUI
import Foundation
import CoreMotion

struct AccelerometerReader: View {
    let motionManager = CMMotionManager()
    //variabile per verifcare se si è o meno in posizione di difesa
    @State private var isDefending = false
    @State private var maxTiltAngleDuringDefense: Double = 0.0
    @State private var showMessage = false


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
                if acceleration.y > 1 {
                    print("ATTACCO: AFFONDO")
                }
                
                if acceleration.x > 1 || acceleration.x < -1 {
                    print("ATTACCO: TAGLIO")
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
        let defenseActivationThreshold: Double = 0.5 // Soglia di inclinazione (in radianti) per attivare la difesa permanente
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
}

