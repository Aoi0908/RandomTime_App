//
//  ContentView.swift
//  Random_WorldTime
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @EnvironmentObject private var sceneDelegate: MySceneDelegate
    
    //MainViewに遷移するための状態変数
    @State private var isMainViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
//                Text("ランダムに世界の時間が出てくるアプリ")
//                    .font(.title2)
//                    .foregroundColor(.green)
//                    .fontWeight(.bold)
                Spacer()
                //アプリ説明のTextFieldの実装
                Text("アプリの説明  \n アプリの説明 \n アプリの説明 \n アプリの説明 \n アプリの説明 \n アプリの説明 \n アプリの説明")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding()
                Spacer()
                //アプリを始めるButtonを実装して、次の画面(MainView)に遷移させるプログラム
                Button("アプリを始める！") {
                    isMainViewPresented = true
                }
                //ここを
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 280, height: 60,alignment: .center)
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(15,antialiased: true)
                .fullScreenCover(isPresented: $isMainViewPresented) {
                    MainView()
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
            .navigationBarTitle(Text("App"))
            
        }
        
    }
}
