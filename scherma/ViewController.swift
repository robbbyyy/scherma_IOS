import Foundation
import CoreMotion
import UIKit

class ViewController: UIViewController {
    
    let manager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startAccelerometerUpdates()
    }
    
    func startAccelerometerUpdates() {
        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.1  // Imposta l'intervallo di aggiornamento dell'accelerometro
            
            manager.startAccelerometerUpdates(to: .main) { (data, error) in
                guard let acceleration = data?.acceleration else {
                    print("Errore nel rilevamento dell'accelerazione: \(error?.localizedDescription ?? "Errore sconosciuto")")
                    return
                }
                
                // Stampiamo i dati di accelerazione sulla console
                print("X: \(acceleration.x), Y: \(acceleration.y), Z: \(acceleration.z)")
            }
        } else {
            print("L'accelerometro non è disponibile.")
        }
    }
}
