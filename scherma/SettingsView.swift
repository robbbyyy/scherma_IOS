//
//  SettingsView.swift
//  scherma
//
//  Created by Lorenzo Guerrini on 16/05/24.
//

import SwiftUI

struct SettingsView: View {
    //  @State  var isSoundOn = true
    @State  var music : Bool = true
    @Binding var isSoundOn: Bool
    
    var body: some View {
        NavigationView{
            HStack{
                Toggle(isOn: $music)
                {
                    
                    Text("MUSIC")
                        .font(.custom("PoetsenOne-Regular", size: 25))
                        .frame(width: 100 , height: 700)
                        .transaction{
                            transaction in transaction.animation = .easeOut(duration: 0.3)
                        }
                    
                    
                }
                .toggleStyle(CustomToggleStyle())
                
                
                
                
                
                Toggle(isOn: $isSoundOn)
                {
                    Text("SOUND")
                        .font(.custom("PoetsenOne-Regular", size: 25))
                    
                        .frame(width: 90 , height: 80)
                        .transaction{
                            transaction in transaction.animation = .easeOut(duration: 0.2)
                        }
                }
                .toggleStyle(CustomToggleStyle())
                
                
               
            }
           
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("SETTINGS")
                        .font(.custom("PoetsenOne-Regular",size: 30))
                        .navigationBarTitleDisplayMode(.inline)
                     
                    
                       
                }
                
                
            }
            .padding(.top, -350)
            
            
        }
        
        
        
    }
}

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? Color.blue : Color.red)
                .frame(width: 51, height: 31)
                .cornerRadius(16)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(2)
                        .offset(x: configuration.isOn ? 10 : -10)
                       
                        
                        .transaction{
                            transaction in transaction.animation = .easeOut(duration: 0.3)
                        }
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding(.horizontal)
    }
}


#Preview {
    SettingsView(isSoundOn: .constant(true))
}
