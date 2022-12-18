//
//  ProblemSolution.swift
//  CodeIt
//
//  Created by octyu on 2022/12/19.
//

import Foundation
import SwiftUI
import CodeMirror_SwiftUI

struct ProblemSolutionView: View {
    
    @State private var codeBlock = ""
    @State private var codeMode = CodeMode.swift.mode()
    @State private var selectedTheme = 0
    @State private var fontSize = 12
    @State private var showInvisibleCharacters = true
    @State private var lineWrapping = true
      
    private var themes = CodeViewTheme.allCases.sorted {
        return $0.rawValue < $1.rawValue
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            GeometryReader { reader in
              ScrollView {
                CodeView(theme: themes[selectedTheme],
                         code: $codeBlock,
                         mode: codeMode,
                         fontSize: fontSize,
                         showInvisibleCharacters: showInvisibleCharacters,
                         lineWrapping: lineWrapping)
                  .onLoadSuccess {
                    print("Loaded")
                  }
                  .onContentChange { newCode in
                    print("Content Change")
                  }
                  .onLoadFail { error in
                    print("Load failed : \(error.localizedDescription)")
                  }
                  .frame(height: reader.size.height)
                  .tag(1)
              }.frame(height: reader.size.height)
        }
        
        }
    }
}
