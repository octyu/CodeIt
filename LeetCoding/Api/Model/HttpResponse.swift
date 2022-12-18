//
//  LCResponse.swift
//  LeetCoding
//
//  Created by octyu on 2022/10/18.
//

import Foundation

public struct HttpResponse<T: Decodable>: Decodable {
    
    public let data: T
}
