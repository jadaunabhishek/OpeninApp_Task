//
//  CustomLink.swift
//  OpeninApp_Task
//
//  Created by Abhishek Jadaun on 23/04/24.
//

import SwiftUI

struct LinkCardView: View {
    let link: Link
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image
            HStack {
                if let imageUrl = link.thumbnail, !imageUrl.isEmpty {
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                                .clipped()
                        default:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                                .foregroundColor(.gray)
                                .clipped()
                        }
                    }
                } else if let imageUrl = link.originalImage, !imageUrl.isEmpty {
                    // Fallback to original image URL if thumbnail is not available
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                                .clipped()
                        default:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 50)
                                .foregroundColor(.gray)
                                .clipped()
                        }
                    }
                } else {
                    // Display placeholder image if no image URL is available
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 50)
                        .foregroundColor(.gray)
                        .clipped()
                }
                
                VStack(alignment: .leading){
                    Text(link.title)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(formattedDateString(dateString: link.createdAt))
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 5)
                .padding(5)
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("\(link.totalClicks)")
                        .font(.subheadline)
                        .foregroundColor(.black)
                    
                    Text("Clicks")
                        .font(.caption2)
                        .foregroundColor(.gray)
                }
                .padding(5)
                
            }
            .padding(.horizontal)
            .padding(.top)
            
            
            HStack {
                Text("\(link.webLink)")
                    .font(.subheadline)
                    .foregroundColor(.blue) 
                    .lineLimit(1)
                
                Spacer()
                
                Image("copy")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue.opacity(0.15))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [4], dashPhase: 2))
                    .foregroundColor(.blue)
            )
            .padding(.top)

            
        }
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top, 5)
    }
    
    private func formattedDateString(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: date)
        }
        return ""
    }
}

struct LinkCardView_Previews: PreviewProvider {
    static var previews: some View {
        let exampleLink = Link(urlId: 1, webLink: "https://example.com", smartLink: "https://smart.example.com", title: "Example Title", totalClicks: 100, originalImage: "https://example.com/image.jpg", thumbnail: nil, timesAgo: "2 hours ago", createdAt: "2024-04-23T10:30:00.000Z", domainId: "domain1", urlPrefix: nil, urlSuffix: "xyz", app: "iOS", isFavourite: false)
        
        return LinkCardView(link: exampleLink)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}


