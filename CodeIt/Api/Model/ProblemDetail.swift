//
//  Question.swift
//  LeetCoding
//
//  Created by octyu on 2022/12/18.
//

import Foundation

public struct ProblemDetail: Decodable {
    
    public let problem: Problem
    
    public struct Problem: Identifiable, Decodable {
        
        public let id: String
        public let title: String
        public let content: String
        
        public init(id: String,
                    title: String,
                    content: String) {
            self.id = id
            self.title = title
            self.content = content
            
        }
        
        enum CodingKeys: String, CodingKey {
            case title, content
            case id = "questionId"
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case problem = "question"
    }
}
