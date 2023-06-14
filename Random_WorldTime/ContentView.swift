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

    var body: some View {
        VStack {
            Text("Ad")
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
    }
}
