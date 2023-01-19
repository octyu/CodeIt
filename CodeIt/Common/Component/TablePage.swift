//
//  TablePage.swift
//  CodeIt
//
//  Created by octyu on 2023/1/19.
//

import Foundation
import SwiftUI

struct TablePage: View {
    
    @Binding public var curPage: Int
    @Binding public var pageSize: Int
    @Binding public var totalCount: Int
    @Binding public var pageCount: Int
    @Binding public var pageInfo: [String]
    
    public var onClickPage: (_ page: Int) -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                if curPage > 1 {
                    curPage -= 1
                }
                onClickPage(curPage)
            } label: {
                Image(systemName: "chevron.left")
            }.buttonStyle(.bordered)
                .disabled(curPage == 1)
            
            ForEach(0..<pageInfo.count, id: \.self) { i in
                if curPage == Int(pageInfo[i]) {
                    Button {
                        onClickPage(Int(pageInfo[i]) ?? 1)
                    } label: {
                        Text(pageInfo[i])
                    }.buttonStyle(.borderedProminent)
                        .disabled(pageInfo[i] == "...")
                } else {
                    Button {
                        let p = Int(pageInfo[i]) ?? 1
                        curPage = p
                        onClickPage(p)
                    } label: {
                        Text(pageInfo[i])
                    }.buttonStyle(.bordered)
                        .disabled(pageInfo[i] == "...")
                }

            }
            Button {
                if curPage < self.pageCount {
                    curPage += 1
                }
                onClickPage(curPage)
            } label: {
                Image(systemName: "chevron.right")
            }.buttonStyle(.bordered)
                .disabled(curPage == pageCount)
        }
    }

}
