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
                Button("ランダムに追加") {
                    // Handle button tap
                    initialize()
                }
                .font(.body)
                .fontWeight(.bold)
                .frame(width: 120, height: 60)
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(15)
                
                Button("全てを追加") {
                    // Handle button tap
                    print("全てを追加Buttonがタップされました")
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
            }
            .onAppear {
                // ビューが表示されたときに初期化処理を行う
                initialize()
            }
        }
    }
    
    func approximateTime(for timeZone: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(identifier: timeZone)
        
        return formatter.string(from: Date())
    }
    
    func initialize() {
        // ランダムに追加ボタンが押されたときの処理を記述
        printRandomCity()
    }
    
    func printRandomCity() {
        guard let randomCity = cities.randomElement() else {
            return
        }
        print("ランダムに選ばれた都市: \(randomCity.city), 時間: \(randomCity.time)")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
