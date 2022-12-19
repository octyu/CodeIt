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
    @State private var selectedLanguage = 0
    @State private var selectedTheme = 0
    @State private var fontSize = 12
    @State private var showInvisibleCharacters = true
    @State private var lineWrapping = true
    
    private var themes = CodeViewTheme.allCases.sorted {
      return $0.rawValue < $1.rawValue
    }
    private var languages = CodeLanguage.list()
    
    var body: some View {
      VStack {
        HStack {
          Picker(selection: $selectedTheme, label: EmptyView()) {
            ForEach(0 ..< themes.count) {
              Text(self.themes[$0].rawValue)
            }
          }
          .frame(minWidth: 100, idealWidth: 150, maxWidth: 150)
          
          Spacer()
          
          Button(action: { lineWrapping.toggle() }) { Text("Wrap") }
          
          Spacer()
          
          Toggle(isOn: $showInvisibleCharacters) {
            Text("Show invisible chars.")
          }
          .padding(.trailing, 8)
            
            Picker(selection: $selectedLanguage, label: Text("language")) {
                ForEach(0 ..< languages.count) {
                    Text(self.languages[$0].rawValue)
                }
            }
          
            ZStack {
                Button {
                    fontSize += 1
                } label: {}
                    .padding(0)
                    .opacity(0)
                    .frame(width: 0, height: 0)
                    .keyboardShortcut("+")
                Button {
                    fontSize -= 1
                } label: {}
                    .padding(0)
                    .opacity(0)
                    .frame(width: 0, height: 0)
                    .keyboardShortcut("-")
            }
        }
        .padding()
        GeometryReader { reader in
          ScrollView {
            CodeView(theme: themes[selectedTheme],
                     code: $codeBlock,
                     mode: languages[selectedLanguage].mode(),
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
      
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
