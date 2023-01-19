//
//  ProblemListView.swift
//  LeetCoding
//
//  Created by octyu on 2022/11/8.
//

import Foundation
import SwiftUI

struct ProblemListView: View {

    @ObservedObject var problemStore: ProblemListStore
    
    @State private var sortOrder = [KeyPathComparator(\ProblemList.Problem.id)]
    @State private var selectedProblem: String?
    
    var sortedProblems: [ProblemList.Problem] {
        return problemStore.data.sorted(using: sortOrder)
    }

    var body: some View {
        problemListV2View
        
    }
    
    var problemListV2View: some View {
        
        NavigationView {
            tableView
            TestView()
        }
    }
    
    var tableView: some View {
        // table use: https://www.fatbobman.com/posts/table_in_SwiftUI/
        VStack {
            internalTable

            TablePage(curPage: $problemStore.curPage,
                      pageSize: $problemStore.pageSize,
                      totalCount: $problemStore.totalCount,
                      pageCount: $problemStore.pageCount,
                      pageInfo: $problemStore.pageInfo) {page in
                problemStore.loadData()
                problemStore.refreshPageInfo()
            }
            .padding(.trailing, 12)
            .padding(.bottom, 5)
        }.frame(minWidth: 600)

    }
    
    var internalTable: some View {
        Table(sortedProblems, selection: $selectedProblem, sortOrder: $sortOrder) {
            TableColumn("No", value: \.id) { problem in
                Text("\(problem.id)")
                    .frame(alignment: .center)
                    .padding(.vertical, 6)
                    .padding(.leading, 2)
            }.width(ideal: 32)
            TableColumn("Title") { problem in
                Text("\(problem.title)")
                    .padding(.vertical, 6)
                    .padding(.leading, 2)
            }
            TableColumn("Solutions") { problem in
                Text("\(problem.solutionNum)")
                    .padding(.vertical, 6)
                    .padding(.leading, 2)
            }.width(50)
            TableColumn("Ac Rate") { problem in
                Text("\(problem.acRatePercent())")
                    .padding(.vertical, 6)
                    .padding(.leading, 2)
            }.width(50)
            TableColumn("Difficulty") { problem in
                Text("\(problem.difficulty.rawValue)")
                    .foregroundColor(problem.difficulty.color())
                    .padding(.vertical, 6)
                    .padding(.leading, 2)
            }.width(72)
        }
    }
    
    var problemListV1View: some View {
        NavigationView {
            List{
                let problems = problemStore.data
                ForEach(0..<problems.count, id: \.self) {i in
                    if i == problems.count - 1 {
                        ProblemListCellView(problem: problems[i], isLast: true, problemStore: problemStore).frame(minHeight: 66)
                    } else {
                        ProblemListCellView(problem: problems[i], isLast: false, problemStore: problemStore).frame(minHeight: 66)
                    }
                }
            }
            .listStyle(.inset)
            .frame(minWidth: 300, idealWidth: 500)

        }
        .navigationTitle("Problems")
        .navigationSubtitle("Solved 547/2200")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
                Button {
                    
                } label: {
                    Image(systemName: "abc")
                }.help("Language Switch")
                
                Button {
                    // action
                } label: {
                    Image(systemName: "sidebar.left")
                }
                .help("Toggle Sidebar")
                
            }
        }
    }
    
    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    

}
