//
//  HtmlText.swift
//  LeetCoding
//
//  Created by octyu on 2022/12/18.
//

import Foundation
import SwiftUI
import Atributika

struct HTMLText: NSViewRepresentable {

    let text: String
    
    // normal text
    let p = Style("p").font(.systemFont(ofSize: 16))
    let code = Style("code")
        .font(.systemFont(ofSize: 12))
        .backgroundColor(NSColor(rgb: 0xf6f8fa))
    let strong = Style("strong").font(.boldSystemFont(ofSize: 16))
    let pre = Style("pre").font(.systemFont(ofSize: 14)).backgroundColor(NSColor(rgb: 0xf6f8fa))
    
    func makeNSView(context: Context) -> NSTextField {
        return NSTextField(labelWithAttributedString: text.style(tags: p, code, strong, pre).attributedString)
    }
    func updateNSView(_ nsTextField: NSTextField, context: Context) {
        // implement protocol
    }
}
