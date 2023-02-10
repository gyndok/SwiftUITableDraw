//
//  NavigationExample.swift
//  SwiftUITableDraw
//
//  Created by Harrison Klein on 2/10/23.
//

import SwiftUI

struct NaviagtionExampleView: View {
  var body: some View {
    NavigationView {
      VStack {
        Text("Primary View")
        NavigationLink(
          /// 2
          destination: Text("Secondary View")) {
            Text("Navigate")
          }
      }
    }
  }
  
  
}

struct NaviagtionExampleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(){
          NaviagtionExampleView()
        }
    }
}

