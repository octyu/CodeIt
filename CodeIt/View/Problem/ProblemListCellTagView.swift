//
//  ProblemListCellTagView.swift
//  CodeIt
//
//  Created by octyu on 2022/12/29.
//

import Foundation
import SwiftUI

struct ProblemListCellTagView: View {
    
    public var text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .padding(.leading, 4)
            .padding(.trailing, 4)
            .padding(.vertical, 2)
            .background(Capsule().fill(.gray.opacity(0.3)))
//            .overlay(
//                Capsule(style: .continuous)
//                    .stroke(Color.black, style: StrokeStyle(lineWidth: 2, dash: [5])))
    }
}
