//
//  LeetCodingApp.swift
//  LeetCoding
//
//  Created by octyu on 2022/10/12.
//

import SwiftUI

var leetCode = LeetCodeApi()
func log(_ log: String) -> EmptyView {
    return EmptyView()
}

@main
struct LeetCodingApp: App {
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
