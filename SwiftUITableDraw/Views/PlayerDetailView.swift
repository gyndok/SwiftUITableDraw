//
//  PlayerDetailView.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/3/23.
//

import SwiftUI
import WebKit

struct PlayerDetailView: View {
    let player: PlayerModel
    
    var body: some View {
        WebView(request: URLRequest(url: URL(string: "https://www.google.com/search?q=\(player.playerName.replacingOccurrences(of: " ", with: "+"))+poker")!))
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView(player: PlayerModel(playerName: "Geffrey Klein", hometown: "Houston, Texas", tableNumber: 278, seatNumber: 3, chipCount: "$236,000", bigBlinds: 23.6))
    }
}

