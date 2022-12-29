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
        public let difficulty: ProblemDifficulty
        public let topicTags: [TopicTag]
        public let acRate: Float
        public let solutionNum: Int
        public let status: ProblemAcState
        
        enum CodingKeys: String, CodingKey {
            case title, titleSlug, difficulty, topicTags, acRate, solutionNum, status
            case id = "frontendQuestionId"
        }
        
        public func acRatePercent() -> String {
            let p = String(format: "%.1f", acRate * 100)
            return "\(p)%"
        }
    }
    
    public struct TopicTag: Identifiable, Decodable {
        
        public let id: String
        public let name: String
        public let slug: String
        public let nameTranslated: String
        
        enum CodingKeys: String, CodingKey {
            case id, name, slug, nameTranslated
        }
    }
}
