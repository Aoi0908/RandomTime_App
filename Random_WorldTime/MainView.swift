//
//  MainView.swift
//  Random_WorldTime
//
//  Created by ひがしもとあおい on 2023/06/21.
//

import SwiftUI
import Foundation

struct MainView: View {
    struct CityTime: Identifiable {
        let id = UUID()
        let city: String
        let time: String
    }
    
    var cities: [CityTime] {
        [
            CityTime(city: "ニューヨーク", time: approximateTime(for: "America/New_York")),
            CityTime(city: "ロンドン", time: approximateTime(for: "Europe/London")),
            CityTime(city: "東京", time: approximateTime(for: "Asia/Tokyo"))
            
        ]
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button("ランダムに選択") {
                    // Handle button tap
                }
                .font(.body)
                .fontWeight(.bold)
                .frame(width: 140, height: 60)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(15)
                
                Button("アプリを閉じる") {
                    // Handle button tap
                }
                .font(.body)
                .fontWeight(.bold)
                .frame(width: 140, height: 60)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15)
            }
            
            List(cities) { city in
                HStack {
                    Text(city.city)
                    Spacer()
                    Text(city.time)
                }
            }
        }
    }
    
    func approximateTime(for timeZone: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: timeZone)
        
        return formatter.string(from: Date())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
