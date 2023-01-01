//
//  Question.swift
//  LeetCoding
//
//  Created by octyu on 2022/12/18.
//

import Foundation

public struct ProblemDetail: Decodable {
    
    public let problem: Problem
    
    enum CodingKeys: String, CodingKey {
        case problem = "question"
    }
    
    public struct Problem: Identifiable, Decodable {
        
        public let id: String
        public let title: String
        public let titleSlug: String
        public let content: String
        public let codeSnippets: [CodeSnippet]
        
        public init(id: String, title: String, titleSlug: String, content: String, codeSnippets: [CodeSnippet]) {
            self.id = id
            self.title = title
            self.titleSlug = titleSlug
            self.content = content
            self.codeSnippets = codeSnippets
        }
        
        enum CodingKeys: String, CodingKey {
            case title, titleSlug, content, codeSnippets
            case id = "questionId"
        }
        
        public func getCodeSnippetsDict() -> [String : CodeSnippet] {
            var dict = [String : CodeSnippet]()
            for codeSnippet in codeSnippets {
                dict[codeSnippet.lang] = codeSnippet
            }
            return dict
        }
        
        public func getFormattedContent() -> String {
            var tmp = self.content
            tmp = tmp.replacingOccurrences(of: "<code>", with:"`")
            tmp = tmp.replacingOccurrences(of: "</code>", with:"`")
            tmp = tmp.replacingOccurrences(of: "<pre>", with:"```")
            tmp = tmp.replacingOccurrences(of: "</pre>", with:"```")
            tmp = tmp.replacingOccurrences(of: "<strong>", with:"**")
            tmp = tmp.replacingOccurrences(of: "<strong class=\"example\">", with:"**")
            tmp = tmp.replacingOccurrences(of: "</strong>", with:"**")
            tmp = tmp.replacingOccurrences(of: "<li>", with:"- ")
            tmp = tmp.replacingOccurrences(of: "</li>", with:"")
            tmp = tmp.replacingOccurrences(of: "<p>", with:"")
            tmp = tmp.replacingOccurrences(of: "</p>", with:"")
            tmp = tmp.replacingOccurrences(of: "<ul>", with:"")
            tmp = tmp.replacingOccurrences(of: "</ul>", with:"")
            tmp = tmp.replacingOccurrences(of: "<sup>", with:"")
            tmp = tmp.replacingOccurrences(of: "</sup>", with:"")
            tmp = tmp.replacingOccurrences(of: "&quot;", with:"\"")
            tmp = tmp.replacingOccurrences(of: "&lt;", with:"<")
            return tmp
        }
    }
    
    public struct CodeSnippet: Decodable {
        
        public let lang: String
        public let langSlug: String
        public let code: String
        
        public init(lang: String, langSlug: String, code: String) {
            self.lang = lang
            self.langSlug = langSlug
            self.code = code
        }
        
        enum CodingKeys: String, CodingKey {
            case lang, langSlug, code
        }
    }
}
