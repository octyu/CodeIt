//
//  SubmissionDetail.swift
//  CodeIt
//
//  Created by octyu on 2022/12/28.
//

import Foundation

public struct SubmissionDetail: Decodable {
    
    public let state: String
    
//    public let statusCode: Int
//    public let statusRuntime: String
//    public let statusMsg: String
//    public let statusMemory: String
//
//    public let correctTestcases: Int
//    public let totalTestcases: Int
    
    public init(state: String) {
        self.state = state
//        self.statusCode = -1
//        self.statusRuntime = "999ms"
//        self.statusMsg = "error"
//        self.statusMemory = "999MB"
//        self.correctTestcases = 0
//        self.totalTestcases = 1
    }
    
    enum CodingKeys: String, CodingKey {
        case state
//        case statusCode = "status_code"
//        case statusRuntime = "status_runtime"
//        case statusMsg = "status_msg"
//        case statusMemory = "status_memory"
//
//        case correctTestcases = "total_correct"
//        case totalTestcases = "total_testcases"
    }
}
