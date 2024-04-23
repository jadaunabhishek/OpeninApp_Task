////
////  FrontendView.swift
////  OpeninApp_Task
////
////  Created by Abhishek Jadaun on 23/04/24.
////
//
//import SwiftUI
//import SwiftUICharts
//
//struct FrontendView: View {
//    
//    @State private var selectedIndex = 0
//    @State private var apiResponse: ApiResponseModel?
//    @State private var selectedOption: Option = .topLinks
//    enum Option {
//        case topLinks
//        case recentLinks
//    }
//    
//    var body: some View {
//        ZStack{
//            Color(.gray).opacity(0.2).edgesIgnoringSafeArea(.all)
//            VStack{
//                ScrollView{
//                    VStack{
//                        HStack{
//                            HStack{
//                                Text("Dashboard")
//                                    .foregroundColor(.white)
//                                    .font(.title2)
//                                    .fontWeight(.bold)
//                                Spacer()
//                                Image("Button")
//                                    .foregroundStyle(Color.red)
//                                
//                            }
//                        }
//                        .offset(y: 20)
//                        .padding()
//                        .frame(height: 110)
//                        .background(.blue)
//                        .offset(y: -40)
//                        
//                        VStack(alignment: .leading) {
//                            Text(greetingForTimeOfDay()) // Display dynamic greeting
//                                .font(.title3)
//                                .foregroundColor(.gray)
//                                .padding(.leading)
//                            
//                            Text("Ajay Manva 👋")
//                                .font(.title)
//                                .fontWeight(.semibold)
//                                .padding(.leading)
//                            
//                            if let recentLinks = apiResponse?.data.recentLinks {
//                                LineChartView(dataPoints: recentLinks.map { Double($0.totalClicks) }, lineColor: .blue)
//                                    .padding()
//                            } else {
//                                Text("Loading...")
//                                    .foregroundColor(.gray)
//                                    .padding()
//                            }
//    
//                            
//                            // whatsapp
//                            HStack {
//                                Image("whatsapp")
//                                    .padding(.horizontal)
//                                
//                                Text("Talk with us")
//                                    .font(.title3)
//                                Spacer()
//                            }
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.green.opacity(0.15))
//                            .cornerRadius(10)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.green, lineWidth: 1)
//                                    .foregroundColor(.black)
//                            )
//                            .padding(.top)
//                            .padding(.horizontal)
//                            
//                            
//                        }
//                        .onAppear {
//                            fetchData()
//                        }
//                    }
//                }
//                .offset(y: 40)
//               
//            }
//            .ignoresSafeArea(.all)
//            
//        }
//    }
//    // function to fetch the data from the api
//    private func fetchData() {
//        guard let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew") else {
//            print("Invalid URL")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print("Error making API request: \(error.localizedDescription)")
//                return
//            }
//            
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                print("Invalid response or status code")
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let decodedResponse = try decoder.decode(ApiResponseModel.self, from: data)
//                
//                DispatchQueue.main.async {
//                    self.apiResponse = decodedResponse
//                }
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
//}
//
//
//struct LineChartView: View {
//    let dataPoints: [Double]
//    let lineColor: Color
//    
//    var body: some View {
//        VStack {
//            if !dataPoints.isEmpty {
//                LineView(data: dataPoints, title: "Overview", legend: "Recent Links", valueSpecifier: "%.0f")
//                    .foregroundColor(lineColor)
//                    .padding()
//                    .frame(maxWidth: .infinity) // Ensure chart expands to fill available width
//                    .background(Color.white) // Optional: Add a background color
//                    .cornerRadius(10) // Optional: Round the corners
//                    .padding(.horizontal) // Optional: Add horizontal padding
//            } else {
//                Text("No data available for line chart")
//                    .foregroundColor(.red)
//                    .padding()
//            }
//        }
//    }
//}
//
//
//
//
//#Preview {
//    FrontendView()
//}
