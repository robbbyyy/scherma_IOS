//
//  ContentView.swift
//  scherma
//
//  Created by Roberto Della Corte on 11/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "moon")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("simm e chiù fort!!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
