//
//  FightPage.swift
//  scherma
//
//  Created by Lorenzo Guerrini on 13/05/24.
//

import Foundation
import SwiftUI


struct FightPage: View {
    @AppStorage("isSoundOn") private var isSoundOn = true
    @AppStorage("soundFirst") private var soundFirst : String = ""
    var body: some View {
        let accelerometerReader = AccelerometerReader(isSoundOn: $isSoundOn, soundFirst: $soundFirst) // Correct initialization
        
        return VStack {
            Text("SEARCH ")
            accelerometerReader
                .font(.system(size: 35))
                .onDisappear {
                    accelerometerReader.stopAccelerometerUpdates()
                    accelerometerReader.stopMotionUpdates()
                }
        }
    }
}



#Preview {
    FightPage()
}
