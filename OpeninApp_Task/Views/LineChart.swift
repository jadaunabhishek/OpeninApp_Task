//
//  Home.swift
//  SwiftCharts
//
//  Created by Abhishek Jadaun on 28/04/24.

import SwiftUI
import Charts

struct LineChart: View {
    @State private var apiResponse: ApiResponseModel?
    @State private var currentTab: String = "7 Days"
    
    // DateFormatter for months
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }()
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Overview")
                        .fontWeight(.regular)
                        .foregroundColor(.gray)
                    Spacer()
                    
                    HStack{
                        Text("22 Aug - 23 Sept")
                            .font(.caption)
                        Image("clock")
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                    .padding(5)
                    .background(
                        RoundedRectangle(cornerRadius: 4, style: .continuous)
                            .fill(Color.white.shadow(.drop(radius: 1.5)))
                    )
                }
                
                AnimatedChart(apiResponse: apiResponse)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
            )
            .padding(.horizontal)
            .padding(.bottom)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onAppear{
            fetchData()
        }
    }
    
    @ViewBuilder
    func AnimatedChart(apiResponse: ApiResponseModel?) -> some View {
        if let recentLinks = apiResponse?.data.topLinks {
            
            // Sort recentLinks by month
            let sortedRecentLinks = recentLinks.sorted(by: { link1, link2 in
                guard let date1 = dateFormatter.date(from: link1.createdAt),
                      let date2 = dateFormatter.date(from: link2.createdAt) else {
                    return false
                }
                return Calendar.current.compare(date1, to: date2, toGranularity: .month) == .orderedAscending
            })
            
            if let maxClicks = sortedRecentLinks.max(by: { $0.totalClicks < $1.totalClicks })?.totalClicks {
                Chart {
                    ForEach(sortedRecentLinks) { link in
                        if let createdAtDate = dateFormatter.date(from: link.createdAt) {
                            let monthAbbreviation = dateFormatter.shortMonthSymbols[Calendar.current.component(.month, from: createdAtDate) - 1]
                            
                            LineMark(
                                x: .value("Month", monthAbbreviation),
                                y: .value("Clicks", Double(link.totalClicks))
                            )
                            .foregroundStyle(Color.blue.gradient)
                            .interpolationMethod(.catmullRom)
                            
                            AreaMark(
                                x: .value("Month", monthAbbreviation),
                                y: .value("Clicks", Double(link.totalClicks))
                            )
                            .foregroundStyle(Color(.blue).opacity(0.1).gradient)
                            .interpolationMethod(.catmullRom)
                        }
                    }
                }
                .chartYScale(domain: 0...(Double(maxClicks)))
                .frame(height: 150)
            } else {
                Text("No data available")
                    .frame(height: 150)
            }
        } else {
            Text("No data available")
                .frame(height: 150)
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


struct LineChart_Previews: PreviewProvider {
    static var previews: some View {
        LineChart()
    }
}

extension Double {
    var stringFormat: String {
        if self >= 10000 && self < 999999 {
            return String(format: "%.1fK", self / 1000).replacingOccurrences(of: ".0", with: "")
        } else if self > 999999 {
            return String(format: "%.1fM", self / 1000000).replacingOccurrences(of: ".0", with: "")
        } else {
            return String(format: "%.1f", self)
        }
    }
}
