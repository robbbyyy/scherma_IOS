import SwiftUI

struct ListSwordsView: View {
    @Binding var selectedPhoto: Photo?
    @State private var photos = [
        Photo(title: "Katana", file: "katana"),
        Photo(title: "Antica", file: "antica"),
        Photo(title: "Viking", file: "viking"),
        Photo(title: "", file: ""),
        Photo(title: "", file: ""),
        Photo(title: "", file: ""),
        Photo(title: "", file: "")
    ]
    @State private var isSelectedActive = false
     @Environment(\.presentationMode) var presentationMode
    // serve per tenere traccia della vista precednte
    var body: some View {
      
        
        NavigationView {
            VStack {
                
                TabView {
                    ForEach($photos, id: \.id) { $photo in
                        VStack {
                            Button(action: {
                                selectedPhoto = photo
                                isSelectedActive = true
                                self.presentationMode.wrappedValue.dismiss()
                                // questa chiude la traccia e simula il back
                            }) {
                                Image(photo.file)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 300, height: 300)
                                    .cornerRadius(8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(selectedPhoto?.id == photo.id ? Color.blue : Color.clear, lineWidth: 3)
                                    )
                            }
                            Text(photo.title)
                                .foregroundColor(.black)
                                .font(.custom("PoetsenOne-Regular",size: 65))
                        }
                        .padding()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .frame(height: 500)
                .padding()// Altezza per il carosello

                Spacer()
            }
           

           
        }
        
       // .navigationTitle("Seleziona spada" )
        .toolbar{
            ToolbarItem(placement: .principal){
                Text("seleziona spada")
                    .font(.custom("PoetsenOne-Regular",size: 30))
                    .navigationBarTitleDisplayMode(.inline)
            
                
            }
        }
        
        
       
        
    }
 

}
struct ReturnContent : View {
    var body: some View {
        NavigationView{
            NavigationLink(destination: ContentView())
            { EmptyView()}
        }
    }
}

struct Photo: Identifiable {
    var id = UUID()
    var title: String
    var file: String
    var multiplyRed = 1.0
    var multiplyGreen = 1.0
    var multiplyBlue = 1.0
    var saturation: Double?
    var contrast: Double?
    var original = true
}


#Preview {
    NavigationView {
        ListSwordsView(selectedPhoto: .constant(Photo(title: "", file: "")))
    }
}

