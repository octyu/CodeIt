//
//  LCProblemList.swift
//  LeetCoding
//
//  Created by octyu on 2022/12/8.
//

import Foundation

public struct ProblemList: Decodable {
    
    public let problemList: PagableProblems
    
    enum CodingKeys: String, CodingKey {
        case problemList = "problemsetQuestionList"
    }
    
    public struct PagableProblems: Decodable {
        
        public let questions: [Problem]
        
        public let hasMore: Bool
        
        public let total: Int
        
        public init(questions: [Problem], hasMore: Bool, total: Int) {
            self.questions = questions
            self.hasMore = hasMore
            self.total = total
        }
        
        enum CodingKeys: String, CodingKey {
            case questions, hasMore, total
        }
    }
    
    public struct Problem: Identifiable, Decodable {
        
        public let id: String
        public let title: String
        public let titleSlug: String
        
        public init(id: String, title: String, titleSlug: String) {
            self.id = id
            self.title = title
            self.titleSlug = titleSlug
            
        }
        
        enum CodingKeys: String, CodingKey {
            case title, titleSlug
            case id = "frontendQuestionId"
        }
    }
}
