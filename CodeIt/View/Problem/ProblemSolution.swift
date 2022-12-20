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
    
    public var codeSnippetsDict: [String: ProblemDetail.CodeSnippet]
    
    @State private var codeBlock = ""
    // default to Java
    @State private var selectedLanguage = 7
    // default to base16-light
    @State private var selectedTheme = 5
    @State private var fontSize = 16
    @State private var showInvisibleCharacters = false
    @State private var lineWrapping = true
    
    private var themes = CodeViewTheme.allCases.sorted {
      return $0.rawValue < $1.rawValue
    }
    private var languages = CodeLanguage.list()
    
    public init(codeSnippetsDict: [String: ProblemDetail.CodeSnippet]) {
        self.codeSnippetsDict = codeSnippetsDict;
    }
    
    var body: some View {
        VStack {
            HStack {
                themePicker
                Spacer()
                Button(action: { lineWrapping.toggle() }) { Text("Wrap") }
                Spacer()
                Toggle(isOn: $showInvisibleCharacters) {
                    Text("Show invisible chars.")
                }
                .padding(.trailing, 8)
                languagePicker
                fontSizeKeyboardShortcut
            }
            .padding()
            editor
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    var themePicker: some View {
        Picker(selection: $selectedTheme, label: EmptyView()) {
            ForEach(0 ..< themes.count, id: \.self) { (index) in
                Text(self.themes[index].rawValue)
            }
        }
        .frame(minWidth: 100, idealWidth: 150, maxWidth: 150)
    }
    
    var languagePicker: some View {
        Picker(selection: $selectedLanguage, label: Text("language")) {
            ForEach(0 ..< languages.count, id: \.self) { (index) in
                Text(self.languages[index].rawValue)
            }
        }.onChange(of: selectedLanguage) { newValue in
            setCodeSnippet(lang: newValue)
        }
    }
    
    var fontSizeKeyboardShortcut: some View {
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
    
    var editor: some View {
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
                .onAppear {
                    setCodeSnippet(lang: self.selectedLanguage)
                }
            }
            .frame(height: reader.size.height)
        }
    }
    
    private func setCodeSnippet(lang: Int) {
        self.codeBlock = codeSnippetsDict[languages[lang].rawValue]?.code ?? ""
    }
}
