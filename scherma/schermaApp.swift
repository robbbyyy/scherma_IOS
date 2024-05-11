import SwiftUI
import CoreMotion

@main
struct schermaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(AccelerometerReader()) // Incorpora il lettore dell'accelerometro come sfondo di ContentView
        }
    }
}

struct AccelerometerReader: View {
    let motionManager = CMMotionManager()
    //variabile per verifcare se si è o meno in posizione di difesa
    @State private var isDefending = false
    @State private var lastDefendingActivation = Date()
    @State private var maxRotationDuringDefense: Double = 0.0
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
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1
            
            motionManager.startGyroUpdates(to: .main) { (data, error) in
                guard let rotationRate = data?.rotationRate else {
                    print("Errore nel rilevamento del giroscopio: \(error?.localizedDescription ?? "Errore sconosciuto")")
                    return
                }
                
                handleDefenseLogic(rotationRate: rotationRate)
            }
        } else {
            print("Il giroscopio non è disponibile")
        }
    }
    
    func handleDefenseLogic(rotationRate: CMRotationRate) {
        let defenseActivationThreshold: Double = 2.0 // Soglia di rotazione (in gradi) per attivare la difesa permanente
        let rotationAngle = rotationRate.x // Assume che il giroscopio fornisca l'angolo di rotazione diretto sull'asse x
        
        if isDefending {
            // Se il telefono è in posizione di difesa permanente, aggiorna la rotazione massima
            if rotationAngle > maxRotationDuringDefense {
                maxRotationDuringDefense = rotationAngle
            }
        }
        
        // Verifica se il telefono è in posizione di difesa permanente
        if abs(rotationAngle) > defenseActivationThreshold {
            // Controlla se è passato abbastanza tempo dall'ultima attivazione della difesa permanente
            if !isDefending || Date().timeIntervalSince(lastDefendingActivation) >= 1.0 {
                print("Uscito dalla posizione di difesa!") // Stampiamo il messaggio quando si esce dalla posizione di difesa
                lastDefendingActivation = Date() // Aggiorna il timestamp dell'ultima attivazione
                isDefending = false // Imposta lo stato di difesa permanente
                maxRotationDuringDefense = rotationAngle // Inizializza la rotazione massima durante la difesa
            }
        } else {
            // Riattiva la difesa permanente solo se il telefono è quasi dritto
            if rotationAngle < maxRotationDuringDefense - 4.07 { // sensibilità
                isDefending = true
                print("Sono in posizione di difesa permanente!")
            }
        }
    }
}





