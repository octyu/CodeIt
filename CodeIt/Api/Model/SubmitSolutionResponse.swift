//
//  SubmitSolutionResponse.swift
//  CodeIt
//
//  Created by octyu on 2022/12/28.
//

import Foundation

public struct SubmitSolutionResponse: Decodable {
    
    public let submissionId: Int
    
    enum CodingKeys: String, CodingKey {
        case submissionId = "submission_id"
    }
}
