//
//  ContentView.swift
//  scherma
//
//  Created by Roberto Della Corte on 11/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedPhoto: Photo?
    @AppStorage("isSoundOn") private var isSoundOn = true
    @AppStorage("soundFirst") private var soundFirst : String
    = ""
   @State private var isSelect = false
    @State private var showAl = false
//Gestire suono spade e memoizzare

    var body: some View {
        
        NavigationView {
            VStack(spacing: 20){
                
                 NavigationLink(destination: FightPage()) {
                    HStack {
                        Image(systemName: "arrowtriangle.right.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black)
                            .transaction{
                                transaction in transaction.animation = .easeOut(duration: 0.3)
                            }
                           // .padding(.top, 50)
                          
                        Text("FIGHT")
                            .font(.custom("PoetsenOne-Regular",size: 25))
                        
                            .foregroundStyle(.black)
                            .transaction{
                                transaction in transaction.animation = .easeOut(duration: 0.50)
                            }
                           // .padding(.leading,26)
                        
                            //.padding(.top, 50)
                    }
                   // .padding()
                    
                 }  .disabled(!isSelect)
                    .onTapGesture {
                        if !isSelect {
                            showAl = true
                        }
                    }
                   /* .alert(isPresented: $showAl) {
                                        Alert(title: Text("Chi guerriero affronta un duello senza spada?")
                                            .font(.custom("PoetsenOne-Regular",size: 25)), message: Text("Seleziona una spada prima di proseguire"), dismissButton: .default(Text("OK")))
                                    }*/
                
                NavigationLink(destination: ListSwordsView(selectedPhoto: $selectedPhoto, soundFirst: $soundFirst, isSelect: $isSelect)
                    )
                {
                    HStack {
                        Image(systemName: "figure.fencing")
                            .resizable()
                            .imageScale(.large)
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black)
                            .transaction{
                                transaction in transaction.animation = .easeOut(duration: 0.3)
                            }
                        
                        Text(" SWORDS")
                            .font(.custom("PoetsenOne-Regular",size: 25))
                            .foregroundStyle(.black)
                            .transaction{
                                transaction in transaction.animation = .easeOut(duration: 0.50)
                            }
                            
                        //SETTINGS
                    }
                    
                    
                   
                  
                    
                }
               
                NavigationLink(destination:SettingsView(isSoundOn: $isSoundOn)){
                    HStack{
                        Image(systemName: "gearshape")
                            .resizable()
                            .imageScale(.large)
                            .frame(width: 35, height: 35)
                            .foregroundStyle(.black)
                            .transaction{
                                transaction in transaction.animation = .easeOut(duration: 0.3)
                            }
                           
                        
                        Text("SETTINGS")
                            .font(.custom("PoetsenOne-Regular",size: 25))
                            .foregroundStyle(.black)
                            .transaction{
                                transaction in transaction.animation = .easeOut(duration: 0.50)
                            }
                           
                           // .padding()
                        
                        
                    }}
                
                // Visualizza l'immagine selezionata
                if let selectedPhoto = selectedPhoto {
                    Image(selectedPhoto.file)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.black)
                        .cornerRadius(.infinity)
                        .padding(.top, 50)
                } else {
                    Text("No sword selected.")
                        .padding(.top, 100)
                        .font(.custom("PoetsenOne-Regular",size: 15))
                        
                }
                
                Spacer()
                    
            }
            .padding(.top, 80)
          //  .multilineTextAlignment(.center)
            
            .navigationTitle("")
            .background(alignment: .bottom) {
                Image("sfondo2")
                             
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .padding([.bottom, .trailing], 0.0)
                     .frame(width: 130, height: 130)
                
            }
            .overlay(
                           Group {
                               if showAl {
                                   CustomAlertView( showAl: $showAl )
                               }
                           } )
          
        }
        
    }
}
struct CustomAlertView: View {
    @Binding var showAl: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Brave! But you need a sword. ")
                    .font(.custom("PoetsenOne-Regular", size: 20))
                    .foregroundColor(.white)
                Text("Select a sword before proceeding. ")
                    .font(.custom("PoetsenOne-Regular", size: 16))
                    .foregroundColor(.white)
                Button(action: {
                    showAl = false
                }) {
                    Text("OK")
                        .font(.custom("PoetsenOne-Regular", size: 18))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.gray)
            .cornerRadius(10)
            .shadow(radius: 10)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
