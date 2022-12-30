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
    
    var body: some View {
        
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
