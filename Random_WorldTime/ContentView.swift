//
//  ContentView.swift
//  Random_WorldTime
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    //バナー表示のための環境変数たち
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @EnvironmentObject private var sceneDelegate: MySceneDelegate
    
    //MainViewに遷移するための状態変数
    @State private var isMainViewPresented = false
    
    // SettingViewへの遷移を管理する状態変数
    @State private var isSettingViewPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("World Time Notifierは、\n世界中のランダムな場所の\n時間を通知するアプリです。\n異なるタイムゾーンや文化に触れ、\n世界の時刻を毎日のルーティンに\n取り入れましょう。")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
                Image("Top_image")
                Spacer()
                NavigationLink(
                    destination: MainView(),
                    isActive: $isMainViewPresented,
                    label: {
                        Text("アプリを始める")
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(width: 280, height: 60)
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(15, antialiased: true)
                    }
                )
                
                //この部分でバナーの表示を実装している
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
            .navigationBarTitle(Text("WorldTime"))
            .navigationBarItems(
                trailing: Button(action: {
                    // SettingViewへの遷移をトリガーする
                    isSettingViewPresented = true
                }) {
                    Image(systemName: "gear.circle")
                }
            )
            // SettingViewへの遷移を実現するNavigationLink
            .background(
                NavigationLink(
                    destination: SettingView(),
                    isActive: $isSettingViewPresented,
                    label: { EmptyView() }
                )
            )
            
            
        }
        
    }
}
