//
//  LeetCodingApp.swift
//  LeetCoding
//
//  Created by octyu on 2022/10/12.
//

import SwiftUI

var leetCode = LeetCodeApi()

@main
struct CodeItApp: App {
    var body: some Scene {
        
        WindowGroup {
            NavigationView {
                SidebarView()
            }
            .environmentObject(CurrentUserStore.shared)
            
        }
//        .windowStyle(HiddenTitleBarWindowStyle())

    }
}
