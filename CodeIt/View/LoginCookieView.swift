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
            Form {
                ZStack(alignment: .leading) {
                    if userCookie.isEmpty {
                        VStack {
                            Text("Input your cookie...")
                                .padding(.top, 30)
                                .padding(.leading, 25)
                                .padding([.top, .horizontal])
                                .opacity(0.6)
                                Spacer()
                        }.zIndex(1)
                    }
                    VStack {
                        TextEditor(text: $userCookie)
                            .frame(minHeight: 20)
                            .font(.system(.callout, design: .monospaced))
                            .lineLimit(20)
                            .padding(.top, 30)
                            .padding(.horizontal, 20)
                            .background(Color(.textBackgroundColor))
                            .border(Color.primary.opacity(0.25), width: 0.5)
                            .padding([.top, .horizontal])
                            .opacity(userCookie.isEmpty ? 0.85 : 1)
                        
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
                        }.padding(.horizontal)
                        
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
