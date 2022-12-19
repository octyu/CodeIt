//
//  CodeLanguage.swift
//  CodeIt
//
//  Created by octyu on 2022/12/19.
//

import Foundation
import CodeMirror_SwiftUI

public enum CodeLanguage: String, CaseIterable {
    
    case cplus = "C++"
    case java = "Java"
    case python = "Python"
    case python3 = "Python3"
    case c = "C"
    case csharp = "C#"
    case javascript = "Javascript"
    case ruby = "Ruby"
    case swift = "Swift"
    case go = "Go"
    case scala = "Scala"
    case kotlin = "Kotlin"
    case rust = "Rust"
    case php = "PHP"
    case typescript = "Typescript"
    case racket = "Racket"
    case erlang = "Erlang"
    case elixir = "Elixir"
    case dart = "Dart"
    
    public static func list() -> [CodeLanguage] {
        CodeLanguage.allCases.sorted {
          return $0.rawValue < $1.rawValue
        }
    }
    
    public func mode() -> Mode {
        switch self {
        case .cplus:
            return CodeMode.cplus.mode()
        case .java:
            return CodeMode.java.mode()
        case .python:
            return CodeMode.python.mode()
        case .python3:
            return CodeMode.python.mode()
        case .c:
            return CodeMode.c.mode()
        case .csharp:
            return CodeMode.csharp.mode()
        case .javascript:
            return CodeMode.javascript.mode()
        case .ruby:
            return CodeMode.ruby.mode()
        case .swift:
            return CodeMode.swift.mode()
        case .go:
            return CodeMode.go.mode()
        case.scala:
            return CodeMode.scala.mode()
        case .kotlin:
            return CodeMode.kotlin.mode()
        case .rust:
            return CodeMode.rust.mode()
        case .php:
            return CodeMode.php.mode()
        case .typescript:
            return CodeMode.typescript.mode()
        case .racket:
            return CodeMode.cplus.mode()
        case .erlang:
            return CodeMode.erlang.mode()
        case .elixir:
            return CodeMode.erlang.mode()
        case .dart:
            return CodeMode.dart.mode()
        }
    }
}
