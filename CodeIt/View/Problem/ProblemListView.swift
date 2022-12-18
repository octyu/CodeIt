//
//  ProblemListView.swift
//  LeetCoding
//
//  Created by octyu on 2022/11/8.
//

import Foundation
import SwiftUI

struct ProblemListView: View {
    
    @State var problems: [ProblemList.Problem]?
    
    var body: some View {
        
        NavigationView {
            List {
                if let problems = problems {
                    ForEach(problems) { problem in
                        ProblemListCellView(problem: problem)
                    }
                }
            }
            .listStyle(.inset)
            .frame(minWidth: 270, idealWidth: 500)
            .foregroundColor(.black)
        }.task {
            await loadData()
        }
        .navigationTitle("Problems")
        .navigationSubtitle("Solved 547/2200")
        .toolbar {
            ToolbarItemGroup(placement: .primaryAction) {
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
    
    func loadData() async {
        Task {
            do {
                if let res = try await leetCode.getProblemList() {
                    DispatchQueue.main.async {
                        problems = res.data.problemList.questions
                    }
                }
            } catch {
                return
            }
        }
    }
}
