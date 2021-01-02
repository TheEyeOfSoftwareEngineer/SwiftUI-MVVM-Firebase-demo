//
//  Store.swift
//  GroceryApp
//
//  Created by yao on 13/12/20.
//

import Foundation

struct Store: Codable {
    var id: String?
    let name: String
    let address: String
    var items: [String]?
}
