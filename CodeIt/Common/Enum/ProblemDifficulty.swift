//
//  ProblemDifficulty.swift
//  CodeIt
//
//  Created by octyu on 2022/12/29.
//

import Foundation
import SwiftUI

public enum ProblemDifficulty: String, Codable {
    
    case easy = "EASY"
    case medium = "MEDIUM"
    case hard = "HARD"
    
    public func color() -> Color {
        switch self {
        case .easy:
            return Color.green
        case .medium:
            return Color.orange
        case .hard:
            return Color.red
        }
    }
}
