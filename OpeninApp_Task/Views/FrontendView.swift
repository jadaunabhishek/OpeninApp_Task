//
//  FrontendView.swift
//  OpeninApp_Task
//
//  Created by Abhishek Jadaun on 23/04/24.
//

import SwiftUI
import SwiftUICharts

struct FrontendView: View {
    
    @State private var selectedIndex = 0
    @State private var apiResponse: ApiResponseModel?
    @State private var selectedOption: Option = .topLinks
    enum Option {
        case topLinks
        case recentLinks
    }
    
    var body: some View {
        ZStack{
            Color(.gray).opacity(0.2).edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView{
                    VStack{
                        HStack{
                            HStack{
                                Text("Dashboard")
                                    .foregroundColor(.white)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Image("Button")
                                    .foregroundStyle(Color.red)
                                
                            }
                        }
                        .offset(y: 20)
                        .padding()
                        .frame(height: 110)
                        .background(.blue)
                        .offset(y: -40)
                        
                        VStack(alignment: .leading) {
                            Text(greetingForTimeOfDay()) // Display dynamic greeting
                                .font(.title3)
                                .foregroundColor(.gray)
                                .padding(.leading)
                            
                            Text("Ajay Manva 👋")
                                .font(.title)
                                .fontWeight(.semibold)
                                .padding(.leading)
                            
                            
                            if let recentLinks = apiResponse?.data.recentLinks {
                                HStack {
                                    
                                    LineChartView(data: recentLinks.map { Double($0.totalClicks) }, title: "Total", legend: "Recent Links")
                                    
                                    PieChartView(data: recentLinks.map { Double($0.totalClicks) }, title: "Total Clicks Over Time", legend: "Recent Links")
                                }
                                .padding(.horizontal)
                            }
                
                            
                            ScrollView(.horizontal) {
                                HStack {
                                    CustomCard(image: "pointer", inputText: "\(apiResponse?.todayClicks ?? 0)", inputContent: "Today's Clicks")
                                    
                                    if let topLocation = apiResponse?.topLocation, !topLocation.isEmpty {
                                        CustomCard(image: "location", inputText: "\(topLocation)", inputContent: "Top Location")
                                    } else {
                                        CustomCard(image: "location", inputText: "No Data", inputContent: "Top Location")
                                    }
                                    
                                    if let topSource = apiResponse?.topSource, !topSource.isEmpty {
                                        CustomCard(image: "Globe", inputText: "\(topSource)", inputContent: "Top Source")
                                    } else {
                                        CustomCard(image: "Globe", inputText: "No Data", inputContent: "Top Source")
                                    }
                                    
                                    if let startTime = apiResponse?.startTime, !startTime.isEmpty {
                                        CustomCard(image: "Globe", inputText: "\(startTime)", inputContent: "Start Time")
                                    } else {
                                        CustomCard(image: "Globe", inputText: "No Data", inputContent: "Start Time")
                                    }
                                    
                                }
                            }
                            .padding([.top, .bottom, .leading])
                            
                            HStack {
                                Image("priceboost")
                                Text("View Analytics")
                                    .font(.title3)
                                    .padding()
                                
                            }
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                            HStack() {
                                
                                PickerButton(title: "Top Links", isSelected: selectedOption == .topLinks) {
                                    self.selectedOption = .topLinks
                                }
                                PickerButton(title: "Recent Links", isSelected: selectedOption == .recentLinks) {
                                    self.selectedOption = .recentLinks
                                }
                                
                                Spacer()
                                
                                Image("search")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                            }
                            .padding()
                            
                            if selectedOption == .topLinks {
                                TopLinksView()
                            } else {
                                RecentLinksView()
                            }
                            
                            
                            HStack {
                                Image("link")
                                Text("View all Links")
                                    .font(.title3)
                                    .padding()
                                
                            }
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity)
                            .background(Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .cornerRadius(10)
                            .padding()
                            .padding(.bottom)
                            
                            
                            // whatsapp
                            HStack {
                                Image("whatsapp")
                                    .padding(.horizontal)
                                
                                Text("Talk with us")
                                    .font(.title3)
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green.opacity(0.15))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.green, lineWidth: 1)
                                    .foregroundColor(.black)
                            )
                            .padding(.top)
                            .padding(.horizontal)
                            
                            
                            
                            //Frequently asked question
                            HStack {
                                Image("questionMark")
                                    .padding(.horizontal)
                                
                                Text("Frequently asked question")
                                    .font(.title3)
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.15))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1)
                                    .foregroundColor(.black)
                            )
                            .padding()
                            .padding(.bottom)
                            
                            


                        }
                        .onAppear {
                            fetchData()
                        }
                    }
                }
                
                .offset(y: 40)
                VStack{
                    HStack() {
                        
                        TabBarButton(imageName: "Mail", buttonName: "Links", isSelected: selectedIndex == 0) {
                            self.selectedIndex = 0
                        }
                        
                        Spacer()
                        
                        TabBarButton(imageName: "Files", buttonName: "Courses", isSelected: selectedIndex == 1) {
                            self.selectedIndex = 1
                        }
                        
                        
                        // Center Button (QR) Offset
                        Button(action: {
                            self.selectedIndex = 2
                        }) {
                            Image("QR")
                                .renderingMode(.original)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .offset(y: -15)
                                .padding(12)
                        }
                        .foregroundColor(selectedIndex == 2 ? .black : .gray) // Change foreground color
                        
                        
                        TabBarButton(imageName: "Media", buttonName: "Campaigns", isSelected: selectedIndex == 3) {
                            self.selectedIndex = 3
                        }
                        
                        Spacer()
                        
                        
                        TabBarButton(imageName: "Generic", buttonName: "Profile", isSelected: selectedIndex == 4) {
                            self.selectedIndex = 4
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .clipShape(CShape())
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white)
                            .offset(y: 30)
                    )
                }
            }
            .ignoresSafeArea(.all)
            
        }
    }
    // function to fetch the data from the api
    private func fetchData() {
        guard let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making API request: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response or status code")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedResponse = try decoder.decode(ApiResponseModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.apiResponse = decodedResponse
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}


// Custom TabBar button
struct TabBarButton: View {
    let imageName: String
    let buttonName: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 35) // Icon size
                    .padding(10)
                    .offset(y: 10)
                Text(buttonName)
                    .font(.caption)
            }
        }
        .foregroundColor(isSelected ? .black : .gray) // Change foreground color
    }
}

// Custom shape for the TabBar button
struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = RoundedRectangle(cornerRadius: 30, style: .continuous)
            .path(in: rect)
        
        return path
    }
}

// Custom Card
struct CustomCard: View {
    var image: String
    var inputText: String
    var inputContent: String
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Image(image)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.vertical, 8)
                
                Text(inputText)
                    .fontWeight(.semibold)
                
                Text(inputContent)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                
            }
            .padding()
        }
        .frame(minWidth: 150)
        .background(Color.white)
        .cornerRadius(20.0)
    }
}


#Preview {
    FrontendView()
}
