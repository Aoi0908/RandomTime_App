import SwiftUI
import Foundation
import GoogleMobileAds


struct MainView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @EnvironmentObject private var sceneDelegate: MySceneDelegate
    @State private var isMainViewPresented = false
    
    struct CityTime: Identifiable {
        let id = UUID()
        let city: String
        let time: String
        var isSelected: Bool = false
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
                    Toggle("", isOn: $cities[cities.firstIndex(where: { $0.id == city.id })!].isSelected)
                        .frame(width: 30) // Toggleの幅を指定する
                        .padding(.trailing, 8) // Toggleの右側の余白を追加する
                    Text(city.city)
                    Spacer()
                    Text(city.time)
                }
                .onTapGesture {
                    handleListItemTap(city)
                }
            }
            Spacer()
            if let vc = sceneDelegate.window?.rootViewController {
                switch (verticalSizeClass, horizontalSizeClass) {
                case (.regular, .regular):
                    BannerView(viewController: vc, windowScene: sceneDelegate.windowScene)
                        .frame(width: 468, height: 60)
                default:
                    BannerView(viewController: vc, windowScene: sceneDelegate.windowScene)
                        .frame(width: 320, height: 50)
                }
            }
            
        }
        .onAppear {
            updateTimes()
        }
    }
    
    //.onAppearの中に入っていたセルの時刻を同期させるプログラムを関数の中に閉じ込め
    func countuptime() {
        //ビューが表示されたときにタイマーを開始
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
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
        let randomCount = Int.random(in: 1...cities.count) // ランダムな数の範囲を設定
        
        // ランダムな数のトグルを選択状態にする
        for _ in 0..<randomCount {
            let randomIndex = Int.random(in: 0..<cities.count)
            cities[randomIndex].isSelected = true
        }
    }
    
    
    func addAllCities() {
        // 全ての都市を追加する処理
        for index in cities.indices {
            cities[index].isSelected = true
        }
    }
    
    func handleListItemTap(_ city: CityTime) {
        // 選択状態の切り替え
        if let index = cities.firstIndex(where: { $0.id == city.id }) {
            cities[index].isSelected.toggle()
            // isSelectedの値に応じた処理をここに追加
            if cities[index].isSelected {
                print("Selected city: \(city.city)")
            } else {
                print("Deselected city: \(city.city)")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

