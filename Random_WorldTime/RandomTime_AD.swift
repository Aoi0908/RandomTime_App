//
//  RandomTime_AD.swift
//  Random_WorldTime
//
//  Created by ふっきー on 2023/06/14.
//

import Foundation
import SwiftUI
import GoogleMobileAds

struct BannerView: UIViewRepresentable {
    let viewController: UIViewController
    let windowScene: UIWindowScene?
                
    func makeCoordinator() -> Coordinator {
        .init()
    }
    
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView()
        bannerView.delegate = context.coordinator
        bannerView.rootViewController = viewController
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" //"ca-app-pub-4858247302327078/1547974015" //"ca-app-pub-4858247302327078~3370993436" "ca-app-pub-3940256099942544/2934735716"
        let request = GADRequest()
        request.scene = windowScene
        bannerView.load(request)
        return bannerView
    }
    
    func updateUIView(_ bannerView: GADBannerView, context: Context) {
    }
        
    class Coordinator: NSObject, GADBannerViewDelegate {
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        }
    }
}
