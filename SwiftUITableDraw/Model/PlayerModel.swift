//
//  playerModel.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/3/23.
//

import Foundation

struct PlayerModel: Codable, Hashable, Identifiable {
  var id: String = UUID().uuidString
  let playerName: String
  let hometown: String
  let tableNumber: String
  let seatNumber: String
  let chipCount: UInt
  let bigBlinds: Double
  let hendonmobURL: String
  
  var symbol: String {
    switch seatNumber {
    case "1":
      return "1.circle.fill"
    case "2":
      return "2.circle.fill"
    case "3":
      return "3.circle.fill"
    case "4":
      return "4.circle.fill"
    case "5":
      return "5.circle.fill"
    case "6":
      return "6.circle.fill"
    case "7":
      return "7.circle.fill"
    case "8":
      return "8.circle.fill"
    case "9":
      return "9.circle.fill"
    case "10":
      return "10.circle.fill"
    default:
      return ""
    }
  }
  
  var bigBlindsString: String {
    if bigBlinds > 0.0 {
      return "\(String(format: "%.1f", bigBlinds)) BBs"
    }else{
      return ""
    }
  }
}



struct PlayerTable: Codable, Hashable, Identifiable {
  var id: String = UUID().uuidString
  let bigBlinds: Double
  let buyIn: Int
  let chips: String
  let day: Int
  let event: String
  let festival: String
  let hometown: String
  let player: String
  let playersRemining: Int
  let restartDate1: Date
  let restartDate2: String
  let seat: String
  let seatNumber: Int
  let serialNumber: Int
  let startingField: Int
  let startingStack: Int
  let tableNumber: Int
  let year: String
  
  var symbol: String {
    switch seatNumber {
    case 1:
      return "1.circle.fill"
    case 2:
      return "2.circle.fill"
    case 3:
      return "3.circle.fill"
    case 4:
      return "4.circle.fill"
    case 5:
      return "5.circle.fill"
    case 6:
      return "6.circle.fill"
    case 7:
      return "7.circle.fill"
    case 8:
      return "8.circle.fill"
    case 9:
      return "9.circle.fill"
    case 10:
      return "10.circle.fill"
    default:
      return ""
    }
  }
  
  var bigBlindsString: String {
    if bigBlinds > 0.0 {
      return "\(String(format: "%.1f", bigBlinds)) BBs"
    }else{
      return ""
    }
    
  }
}





