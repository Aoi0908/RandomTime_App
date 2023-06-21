//
//  Random_WorldTimeApp.swift
//  Random_WorldTime
//
//  Created by ひがしもとあおい on 2023/06/07.
//テスト

import SwiftUI
import GoogleMobileAds

import SwiftUI
import GoogleMobileAds

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class MyAppDelegate: NSObject, UIApplicationDelegate, ObservableObject, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                     launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        
        // リクエストのメソッド呼び出し
        NotificationManager.instance.requestPermission()
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}

class MySceneDelegate: NSObject, UIWindowSceneDelegate, ObservableObject {
    var windowScene: UIWindowScene?
    var window: UIWindow? {
        windowScene?.keyWindow
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        windowScene = scene as? UIWindowScene
    }
}

extension MyAppDelegate {
    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(
            name: nil,
            sessionRole: connectingSceneSession.role)
        if connectingSceneSession.role == .windowApplication {
            configuration.delegateClass = MySceneDelegate.self
        }
        return configuration
    }
}
