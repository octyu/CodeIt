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
    
    func makeNSView(context: Context) -> NSTextField {
        return NSTextField(labelWithAttributedString: text.style(tags: p).attributedString)
    }
    func updateNSView(_ nsTextField: NSTextField, context: Context) {
        // implement protocol
    }
}
