//
//  AppDelegate.swift
//  Random_WorldTime
//
//  Created by ひがしもとあおい on 2023/06/21.
//

import Foundation
import NotificationCenter
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       // リクエストのメソッド呼び出し
       NotificationManager.instance.requestPermission()
       
       UNUserNotificationCenter.current().delegate = self

       return true
   }

}

