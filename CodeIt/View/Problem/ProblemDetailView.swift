//
//  AnswerQuestionView.swift
//  LeetCoding
//
//  Created by octyu on 2022/12/18.
//

import Foundation
import SwiftUI

struct ProblemDetailView: View {
    
    var problem: ProblemList.Problem
    
    @State var problemDetail: ProblemDetail.Problem?
    
    var body: some View {
        
        // for scroll
        List {
            VStack {
                if let detail = problemDetail {
                    HStack {
                        Text(detail.title)
                            .font(.title)
                        Spacer()
                    }
                    HTMLText(text: detail.content)
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
