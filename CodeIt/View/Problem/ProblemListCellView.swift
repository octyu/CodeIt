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
                    HStack(alignment: .firstTextBaseline, spacing: 6) {
                        Text("\(problem.id). \(problem.title)").lineLimit(1).font(Font.body.bold())
                        if problem.status == ProblemAcState.ac {
                            Image(systemName: "checkmark.seal").foregroundColor(.blue)
                        }
                        Spacer()
                        Text(problem.difficulty.rawValue).foregroundColor(problem.difficulty.color()).lineLimit(1)
                        
                    }
                    HStack {
                        Label("\(problem.solutionNum)", systemImage: "doc.plaintext").font(.system(size: 12)).lineLimit(1)
                        Label(problem.acRatePercent(), systemImage: "person.fill.checkmark").font(.system(size: 12)).lineLimit(1)
                        Spacer()
                    }
                    Spacer()
                    HStack(spacing: 6) {
                        ForEach(problem.topicTags) { topicTag in
                            ProblemListCellTagView(text: topicTag.name)
                        }
                        Spacer()
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
