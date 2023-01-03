//
//  AnswerQuestionView.swift
//  LeetCoding
//
//  Created by octyu on 2022/12/18.
//

import Foundation
import SwiftUI
import MarkdownUI

struct ProblemDetailView: View {
    
    var problem: ProblemList.Problem
    
    @State var problemDetail: ProblemDetail.Problem?
    @State private var text = #"""
      ## Try CommonMark
      You can try CommonMark here.  This dingus is powered by
      [MarkdownUI](https://github.com/gonzalezreal/MarkdownUI), a
      CommonMark renderer for SwiftUI.
      1. item one
      1. item two
         - sublist
         - sublist
      """#
    
    var body: some View {
        
        // for scroll
        List {
            VStack {
                TextEditor(text: $text)
                  .font(.system(.callout, design: .monospaced))
                  .lineLimit(20)
                  .padding()
                  .background(Color(.textBackgroundColor))
                  .border(Color.primary.opacity(0.25), width: 0.5)
                  .padding([.top, .horizontal])

                ScrollView {
                    Markdown(text)
                    .padding()
                }
                .border(Color.primary.opacity(0.25), width: 0.5)
                .padding([.bottom, .horizontal])
                
                
                if let detail = problemDetail {
                    HStack {
                        Text(detail.title)
                            .font(.title)
                        Spacer()
                    }
//                    HTMLText(text: detail.content)
                    Markdown(detail.getFormattedContent())
                    Spacer()
                    ProblemSolutionView(problemDetail: detail)
                        .frame(height: 600)
                }
            }.task {
                await loadData()
            }.padding()
        }
    }
    
    func loadData() async {
        Task {
            do {
                if let res = try await leetCode.getProblemDetail(titleSlug: problem.titleSlug) {
                    DispatchQueue.main.async {
                        problemDetail = res.data.problem
                    }
                }
            } catch {
                return
            }
        }
    }
}
