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
    @Published var pageSize = 15
    @Published var curPage = 1
    @Published var pageCount = 0
    @Published var pageInfo = [String]()
    
    public init() {
        loadData()
    }
    
    public func loadData() {
        Task {
            do {
                if let res = try await leetCode.getProblemList(skipNum: (curPage - 1)*pageSize, limit: pageSize) {
                    DispatchQueue.main.async {
                        self.data = res.data.problemList.questions
                        self.count = res.data.problemList.questions.count
                        self.totalCount = res.data.problemList.total
                        self.pageCount = self.getPageCount(totalCount: self.totalCount, pageSize: self.pageSize)
                        self.refreshPageInfo()
                    }
                }
            } catch {
                return
            }
        }
    }
    
    func getPageCount(totalCount: Int, pageSize: Int) -> Int {
        return Int(ceil(Double(totalCount) / Double(pageSize)))
    }
    
    func refreshPageInfo() {
        var array = [String]()
        if pageCount <= 7 {
            for i in 1...7 {
                array.append("\(i)")
            }
        } else {
            if curPage < 5 {
                for i in 1...5 {
                    array.append("\(i)")
                }
                array.append("...")
                array.append("\(pageCount)")
            } else if curPage > pageCount - 4 {
                array.append("1")
                array.append("...")
                for i in (pageCount - 4)...pageCount {
                    array.append("\(i)")
                }
            } else {
                array.append("1")
                array.append("...")
                array.append("\(curPage - 1)")
                array.append("\(curPage)")
                array.append("\(curPage + 1)")
                array.append("...")
                array.append("\(pageCount)")
            }
        }
        self.pageInfo = array
    }
}
