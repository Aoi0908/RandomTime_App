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
            //Spacer()
            HStack {
                Button(action: {
                    addRandomCity()
                }) {
                    HStack {
                        Text("ランダムに追加")
                    }
                }.buttonStyle(GradientButtonStyle())
                
                
                Button(action: {
                    addAllCities()
                }) {
                    HStack {
                        Text("全てを追加")
                    }
                }.buttonStyle(GradientButtonStyle())
                
                Button(action: {
                    removeAllCities()
                }) {
                    HStack {
                        Text("選択を解除")
                    }
                }.buttonStyle(GradientButtonStyle())
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
        var cities: [CityTime] = []
        
        // アメリカ
        let americaCities = [
            CityTime(city: "ニューヨーク", time: approximateTime(for: "America/New_York")),
            CityTime(city: "ハワイ", time: approximateTime(for: "Pacific/Honolulu")),
            CityTime(city: "ロサンゼルス", time: approximateTime(for: "America/Los_Angeles"))
        ]
        cities += americaCities
        
        // ヨーロッパ
        let europeCities = [
            CityTime(city: "ロンドン", time: approximateTime(for: "Europe/London")),
            CityTime(city: "ベルリン", time: approximateTime(for: "Europe/Berlin")),
            CityTime(city: "ヘルシンキ", time: approximateTime(for: "Europe/Helsinki")),
            CityTime(city: "ルーマニア", time: approximateTime(for: "Europe/Rumania")),
            CityTime(city: "ワルシャワ", time: approximateTime(for: "Europe/Warsaw"))
        ]
        cities += europeCities
        
        // アジア
        let asiaCities = [
            CityTime(city: "東京", time: approximateTime(for: "Asia/Tokyo")),
            CityTime(city: "上海", time: approximateTime(for: "Asia/Shanghai")),
            CityTime(city: "インドネシア", time: approximateTime(for: "Asia/Indonesia")),
            CityTime(city: "タイ", time: approximateTime(for: "Asia/Bangkok")),
            CityTime(city: "ムンバイ", time: approximateTime(for: "Asia/Kolkata"))
        ]
        cities += asiaCities
        
        // その他の地域
        let otherCities = [
            CityTime(city: "リオデジャネイロ", time: approximateTime(for: "America/Sao_Paulo")),
        ]
        cities += otherCities
        
        self.cities = cities
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
    
    func removeAllCities() {
        for index in cities.indices {
            cities[index].isSelected = false
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

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .font(.body)
            .fontWeight(.bold)
            .shadow(color: Color.gray, radius: 2, x: 0, y: 2)
    }
}






struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

