//
//  ContentView.swift
//  scherma
//
//  Created by Roberto Della Corte on 11/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedPhoto: Photo?

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                NavigationLink(destination: FightPage()) {
                    HStack {
                        Image(systemName: "arrowtriangle.right.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black)
                            .padding(.top, 50)
                        Text("FIGHT")
                            .font(.custom("PoetsenOne-Regular",size: 25))
                            
                            .foregroundStyle(.black)
                            .font(.system(.callout))
                            .padding(.top, 50)
                    }
                    .padding(30)
                }
                
                NavigationLink(destination: ListSwordsView(selectedPhoto: $selectedPhoto)
                    )
                {
                    HStack {
                        Image(systemName: "figure.fencing")
                            .resizable()
                            .imageScale(.large)
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black)
                        
                        Text(" SWORDS")
                            .font(.custom("PoetsenOne-Regular",size: 25))
                            
                            .foregroundStyle(Color.black)
                           
                            
                        //SETTINGS
                    }
                }
                
                // Visualizza l'immagine selezionata
                if let selectedPhoto = selectedPhoto {
                    Image(selectedPhoto.file)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.black)
                        .padding(.top, 40)
                } else {
                    Text("")
                }
                
                Spacer()
            }
            .navigationTitle("")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
