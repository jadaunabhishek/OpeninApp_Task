//  RecentLinksViews.swift
//  OpeninApp_Task
//
//  Created by Abhishek Jadaun on 23/04/24.
//

import SwiftUI
import Foundation
import SwiftUICharts


struct RecentLinksView: View {
    @State private var apiResponse: ApiResponseModel?
    
    var body: some View {
        VStack {
            if let recentLinks = apiResponse?.data.recentLinks {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(recentLinks) { link in
                            LinkCardView(link: link)
                                .padding(.horizontal)
                        }
                    }
                }
            } else {
                Text("Loading...")
                    .padding()
            }
        }
        .onAppear {
            fetchData()
        }
    }
    
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


struct RecentLinksView_Previews: PreviewProvider {
    static var previews: some View {
        RecentLinksView()
    }
}

