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
    var isLast: Bool
    
    @ObservedObject var problemStore: ProblemListStore
    
    var body: some View {
        
        NavigationLink {
            ProblemDetailView(problem: problem)
        } label: {
            LazyVStack {
                if self.isLast {
                    cellView.onAppear {
                        print("load more")
                        problemStore.loadData()
                    }
                } else {
                    cellView
                }
                Divider()
            }
        }
        .buttonStyle(PlainButtonStyle())
                
    }
    
    var cellView: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text("\(problem.id). \(problem.title)").lineLimit(1).font(Font.body.bold())
                if problem.status == ProblemAcState.ac {
                    Image(systemName: "checkmark.seal").foregroundColor(.blue)
                }
                Spacer()
                
            }
            HStack {
                Label("\(problem.solutionNum)", systemImage: "doc.plaintext").font(.system(size: 12)).lineLimit(1)
                Label(problem.acRatePercent(), systemImage: "person.fill.checkmark").font(.system(size: 12)).lineLimit(1)
                Label {
                    Text(problem.difficulty.rawValue).font(.system(size: 12)).lineLimit(1)
                        .foregroundColor(problem.difficulty.color())
                } icon: {
                    Image(systemName: "flag.checkered")
                }
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
    }
}
