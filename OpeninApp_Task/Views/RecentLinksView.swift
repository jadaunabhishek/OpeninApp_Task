//
//  RecentLinksViews.swift
//  OpeninApp_Task
//
//  Created by Abhishek Jadaun on 23/04/24.
//

import SwiftUI
import Foundation
import SwiftUICharts

func greetingForTimeOfDay() -> String {
    let hour = Calendar.current.component(.hour, from: Date())
    
    switch hour {
    case 0..<12:
        return "Good Morning"
    case 12..<17:
        return "Good Afternoon"
    case 17..<24:
        return "Good Evening"
    default:
        return "Hello"
    }
}


struct ApiResponseModel: Codable {
    let status: Bool?
    let statusCode: Int?
    let message: String?
    let supportWhatsappNumber: String?
    let extraIncome: Double?
    let totalLinks: Int?
    let totalClicks: Int?
    let todayClicks: Int?
    let topSource: String?
    let topLocation: String?
    let startTime: String?
    let linksCreatedToday: Int?
    let appliedCampaign: Int?
    let data: ApiData
}

struct ApiData: Codable {
    let recentLinks: [Link]
    let topLinks: [Link]
    let favouriteLinks: [Link]?
    let overallUrlChart: [String: Int]?
}

struct Link: Codable, Identifiable {
    let urlId: Int
    let webLink: String
    let smartLink: String
    let title: String
    let totalClicks: Int
    let originalImage: String?
    let thumbnail: String?
    let timesAgo: String
    let createdAt: String
    let domainId: String
    let urlPrefix: String?
    let urlSuffix: String
    let app: String
    let isFavourite: Bool
    
    var id: Int { urlId }
}

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


struct LinkRow: View {
    let link: Link
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(link.title)
                .font(.headline)
            Text("Total Clicks: \(link.totalClicks)")
                .font(.subheadline)
            if let imageUrl = URL(string: link.originalImage!) {
                AsyncImage(url: imageUrl)
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
            }
        }
        .padding(8)
    }
}

struct RecentLinksView_Previews: PreviewProvider {
    static var previews: some View {
        RecentLinksView()
    }
}

