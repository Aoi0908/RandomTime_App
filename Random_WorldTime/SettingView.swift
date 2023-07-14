//
//  SettingView.swift
//  Random_WorldTime
//
//  Created by ひがしもとあおい on 2023/07/14.
//

//通知設定(通知オン・オフ)

//アプリのトラッキングの許可

//ダークモードの設定(おん・おふ)

//利用規約ページ(Notionに遷移だから適当で良い)

import SwiftUI

struct SettingView: View {
    @AppStorage("isNotificationEnabled") private var isNotificationEnabled = true

    var body: some View {
        Form {
            Section(header: Text("通知設定")) {
                Toggle(isOn: $isNotificationEnabled) {
                    Text("通知を受け取る")
                }
            }
            Section(header: Text("その他の設定")) {
                Text("テスト")
            }
        }
        .navigationBarTitle(Text("設定"))
    }
}

