//
//  ApiResponse.swift
//  OpeninApp_Task
//
//  Created by Abhishek Jadaun on 28/04/24.
//

import SwiftUI

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

