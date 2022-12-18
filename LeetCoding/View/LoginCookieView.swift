//
//  ProfileView.swift
//  LeetCoding
//
//  Created by octyu on 2022/10/13.
//

import Foundation
import SwiftUI
import Kingfisher
import CodeMirror_SwiftUI

struct LoginCookieView: View {
    
    @EnvironmentObject var currentUser: CurrentUserStore
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var showLoginView: Bool
    @Binding var userCookie: String
  
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Cookie")
                Spacer()
            }.padding(EdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20))
            
            
            Form {
                VStack {
                
                    TextEditor(text: $userCookie)
                        .lineSpacing(1)
                        .font(.title3)
                        .border(Color.gray, width: 1)
                        .frame(minHeight: 20)
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            self.showLoginView.toggle()
                        } label: {
                            Text("取消")
                        }
                        
                        Button {
                            self.showLoginView.toggle()
                            saveCookie()
                        } label: {
                            Text("登陆")
                        }
                    }
                    
                }
            }.padding([.horizontal, .bottom], 20)
        }.frame(minWidth: 480, minHeight: 270)

    }

    func saveCookie() {
        if userCookie.isEmpty {
            return
        }
        currentUser.saveCookie(cookie: userCookie)
        
    }
}
