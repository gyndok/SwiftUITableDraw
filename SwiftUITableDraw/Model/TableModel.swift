//
//  Models.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/3/23.
//

import Foundation

struct TableDrawModel: Codable, Hashable, Identifiable {
    var id: String = UUID().uuidString
    let festival: String
    let event: String
    let tableNumber: Int
    let seatNumber: Int
    let day: Int
    let date: String
}



