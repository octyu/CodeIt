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
            VStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(problem.id). \(problem.title)").lineLimit(1).font(Font.body.bold())
                    Spacer()
                    HStack(spacing: 6) {
                        Label("22312", systemImage: "doc.text")
                        Spacer()
                        ProblemListCellTagView(text: "Hash Table")
                        ProblemListCellTagView(text: "Array")
                    }
                }
                .padding([.leading, .trailing], 4)
                .padding([.top, .bottom], 2)
                Divider()
            }

        }
        .buttonStyle(PlainButtonStyle())

    }
}
