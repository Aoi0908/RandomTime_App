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
    
    @State var cities: [CityTime] = []
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button("ランダムに追加") {
                    addRandomCity()
                }
                .font(.body)
                .fontWeight(.bold)
                .frame(width: 120, height: 60)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(15)
                
                Button("全てを追加") {
                    addAllCities()
                }
                .font(.body)
                .fontWeight(.bold)
                .frame(width: 120, height: 60)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(15)
                
                Button("選択して追加") {
                    // Handle button tap
                }
                .font(.body)
                .fontWeight(.bold)
                .frame(width: 120, height: 60)
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
                .onTapGesture {
                    handleListItemTap(city)
                }
            }
        }
        .onAppear {
            // ビューが表示されたときにタイマーを開始
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                updateTimes()
            }
            updateTimes()
        }
    }
    
    func updateTimes() {
        cities = [
            CityTime(city: "ニューヨーク", time: approximateTime(for: "America/New_York")),
            CityTime(city: "ロンドン", time: approximateTime(for: "Europe/London")),
            CityTime(city: "東京", time: approximateTime(for: "Asia/Tokyo"))
        ]
    }
    
    func approximateTime(for timeZone: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: timeZone)
        
        return formatter.string(from: Date())
    }
    
    func addRandomCity() {
        // ランダムな都市を追加する処理
    }
    
    func addAllCities() {
        // 全ての都市を追加する処理
    }
    
    func handleListItemTap(_ city: CityTime) {
        // 選択された都市の処理をここに記述
        print("Selected city: \(city.city)")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
