//
//  Table.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/17/23.
//

import Foundation

struct Table: Decodable {
  let seats: [String]
  let tableNumber: String
  
  enum CodingKeys: String, CodingKey {
    case seats
    case tableNumber = "table_number"
  }
}
