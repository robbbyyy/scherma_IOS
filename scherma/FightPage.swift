//
//  FightPage.swift
//  scherma
//
//  Created by Lorenzo Guerrini on 13/05/24.
//

import Foundation
import SwiftUI

struct FightPage : View {
    @State private var accelerometerReader = AccelerometerReader()
    var body: some View {
        Text("SEARCH ")
        accelerometerReader
            .font(.system(size: 35))
            .onDisappear {
                self.accelerometerReader.stopAccelerometerUpdates()
                self.accelerometerReader.stopMotionUpdates()
            }
    }
}

#Preview {
    FightPage()
}
