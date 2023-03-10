//
//  SidebarView.swift
//  LeetCoding
//
//  Created by octyu on 2022/11/8.
//

import Foundation
import SwiftUI
import Kingfisher

struct SidebarView: View {
    
    @EnvironmentObject var currentUser: CurrentUserStore
    @EnvironmentObject var problemList: ProblemListStore
    
    @State var selection: Int?
    @State var showLoginView = false
    @State var userCookie = ""
    
    @State var pageSize = 50
    
    var body: some View {
        
        VStack {
            
            List() {
                Section() {
                    NavigationLink(destination: ProblemListView(problemStore: problemList), tag: 0, selection: $selection) {
                        Label("Problems", systemImage: "doc.text")
                    }
                    NavigationLink(destination: TestView()) {
                        Label("Test", systemImage: "doc.text")
                    }
                }.onAppear {
                    if self.selection == nil {
                        self.selection = 0
                    }
                }
            }
            Spacer()
            
            if let _ = currentUser.userProfile {
                profileView
            } else {
                loginView
            }
        }
    }
    
    var loginView: some View {
        
        HStack {
            Spacer()
            
            Button(action: {
                self.showLoginView.toggle()
            }) {
                Text("未登陆")
            }.sheet(isPresented: $showLoginView) {
                LoginCookieView(showLoginView: $showLoginView, userCookie: $userCookie)
            }.padding([.trailing], 2)
            
            Image(systemName: "poweroutlet.type.f")
                .resizable()
                .frame(width: 16, height: 16)
                .mask(RoundedRectangle(cornerRadius: 8))
                .padding([.leading], 2)
            
        }.padding(15)
    }
    
    var profileView: some View {
        HStack {
            KFImage.url(URL(string: currentUser.userProfile?.profile.avatar ?? ""))
            .resizable()
            .frame(width: 48, height: 48)
            .mask(RoundedRectangle(cornerRadius: 8))
        
            
            VStack {
                Text(currentUser.userProfile?.profile.nickname ?? "").lineLimit(1)
                
                Button(action: {
                    self.showLoginView.toggle()
                    self.userCookie = currentUser.userCookie!
                }) {
                    Text("切换账号")
                }.sheet(isPresented: $showLoginView) {
                    LoginCookieView(showLoginView: $showLoginView, userCookie: $userCookie)
                }
            }
            
        }.padding(20)
    }
}
