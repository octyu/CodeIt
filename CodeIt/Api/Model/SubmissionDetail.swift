//
//  SubmissionDetail.swift
//  CodeIt
//
//  Created by octyu on 2022/12/28.
//

import Foundation

public struct SubmissionDetail: Decodable {
    
    public let statusCode: Int
    public let statusRuntime: String
    public let statusMsg: String
    public let statusMemory: String
    
    public let correctTestcases: Int
    public let totalTestcases: Int
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusRuntime = "status_runtime"
        case statusMsg = "status_msg"
        case statusMemory = "status_memory"
        
        case correctTestcases = "total_correct"
        case totalTestcases = "total_testcases"
    }
}
