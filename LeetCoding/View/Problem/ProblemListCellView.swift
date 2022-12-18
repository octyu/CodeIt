//
//  ProblemListCell.swift
//  LeetCoding
//
//  Created by octyu on 2022/12/14.
//

import Foundation
import SwiftUI

struct ProblemListCellView: View {
    
    var problem: ProblemList.Problem
    
    var body: some View {
        
        NavigationLink {
            ProblemDetailView(problem: problem)
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                Text("\(problem.id). \(problem.title)")
            }
        }

    }
}
