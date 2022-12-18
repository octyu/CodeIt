//
//  LCUserProfile.swift
//  LeetCoding
//
//  Created by octyu on 2022/10/12.
//

import Foundation

public struct UserProfile: Decodable {

    public let profile: Profile
    
    public struct Profile: Decodable {
        
        public let username: String
        public let nickname: String
        public let avatar: String
        
        public init(username: String, nickname: String, avatar: String) {
            self.username = username
            self.nickname = nickname
            self.avatar = avatar
        }
        
        enum CodingKeys: String, CodingKey {
            case username, avatar
            case nickname = "realName"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case profile = "userStatus"
    }
}
