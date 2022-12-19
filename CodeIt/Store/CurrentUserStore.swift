//
//  CurrentUserStore.swift
//  LeetCoding
//
//  Created by octyu on 2022/10/12.
//

import Foundation
import KeychainAccess


public class CurrentUserStore: ObservableObject {
    
    public static let shared = CurrentUserStore()

    @Published public private(set) var userProfile: UserProfile?
    @Published public private(set) var userCookie: String? {
        didSet {
            leetCode.cookie = userCookie
        }
    }
    
    let keychain = Keychain(service: "com.github.octyu.LeetCoding")
    let keychainCookieKey = "userCookie"
    
    public init() {
        if let cookie = readCookie() {
            userCookie = cookie
        }
    }
    
    public func readCookie() -> String? {
        keychain[keychainCookieKey]
    }
    
    public func saveCookie(cookie: String) {
        userCookie = cookie
        keychain[keychainCookieKey] = cookie
        fetchUser()
    }
    
    private func fetchUser() {
        Task {
            do {
                if let res = try await leetCode.getUserProfile() {
                    DispatchQueue.main.async {
                        self.userProfile = res.data
                    }
                }
            } catch {
                return
            }
        }
        
    }
}
