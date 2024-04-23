//import SwiftUI
//
//struct ContentView: View {
//    @State private var selectedIndex = 0
//    
//    var body: some View {
//        VStack(spacing:0) {
//            Rectangle()
//                .fill(.blue)
//                .edgesIgnoringSafeArea(.all)
//                .frame(height: 100)
//            
//            
//            ZStack{
//                Rectangle()
//                    .fill(.gray).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
//                    .cornerRadius(30)
//                    .offset(y: -35)
//                
//                
//                Spacer()
//                
//                HStack() {
//                    TabBarButton(imageName: "Mail", isSelected: selectedIndex == 0) {
//                        self.selectedIndex = 0
//                    }
//                    
//                    Spacer()
//                    
//                    TabBarButton(imageName: "Files", isSelected: selectedIndex == 1) {
//                        self.selectedIndex = 1
//                    }
//                    
//                    Spacer()
//                    
//                    // Center Button (QR) Offset
//                    Button(action: {
//                        self.selectedIndex = 2
//                    }) {
//                        Image("QR")
//                            .renderingMode(.original)
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 70, height: 70)
//                            .offset(y: -15)
//                            .padding(12)
//                    }
//                    .foregroundColor(selectedIndex == 2 ? .black : .gray) // Change foreground color
//                    
//                    Spacer()
//                    
//                    TabBarButton(imageName: "Media", isSelected: selectedIndex == 3) {
//                        self.selectedIndex = 3
//                    }
//                    
//                    Spacer()
//                    
//                    TabBarButton(imageName: "Generic", isSelected: selectedIndex == 4) {
//                        self.selectedIndex = 4
//                    }
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 10)
//                .clipShape(CShape())
//                .shadow(radius: 5)
//                .background(
//                    RoundedRectangle(cornerRadius: 15)
//                        .fill(Color.white)
//                        .frame(height: 100)
//                        .frame(width: .infinity)
//                        .offset(y: 30)
//                )
//            }
//            .edgesIgnoringSafeArea(.bottom)
//            .ignoresSafeArea(.all)
//        }
//    }
//}
//    
//
//
//struct TabBarButton: View {
//    let imageName: String
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            Image(imageName)
//                .renderingMode(.original)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 35, height: 35) // Icon size
//                .padding(10)
//                .offset(y: 10)
//        }
//        .foregroundColor(isSelected ? .black : .gray) // Change foreground color
//    }
//}
//
//struct CShape: Shape {
//    func path(in rect: CGRect) -> Path {
//        let path = RoundedRectangle(cornerRadius: 30, style: .continuous)
//            .path(in: rect)
//        
//        return path
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
