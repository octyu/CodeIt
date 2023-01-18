//
//  ProblemListStore.swift
//  CodeIt
//
//  Created by octyu on 2022/12/30.
//

import Foundation

public class ProblemListStore: ObservableObject {
    
    public static let shared = ProblemListStore()
    
    @Published var data = [ProblemList.Problem]()
    @Published var count = 0
    @Published var totalCount = 0
    
    public init() {
        loadData()
    }
    
    public func loadData() {
        Task {
            do {
                if let res = try await leetCode.getProblemList(skipNum: count) {
                    DispatchQueue.main.async {
                        self.data = res.data.problemList.questions
                        self.count = res.data.problemList.questions.count
                        self.totalCount = res.data.problemList.total
                    }
                }
            } catch {
                return
            }
        }
    }
}
