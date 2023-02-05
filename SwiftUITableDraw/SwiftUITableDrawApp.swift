//
//  SwiftUITableDrawApp.swift
//  SwiftUITableDraw
//
//  Created by Geffrey Klein on 2/2/23.
//


import SwiftUI
import Firebase
import FirebaseCore
import FirebaseFirestore




class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
     

    return true
  }
}

@main
struct SwiftUITableDrawApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                TourneyListView()
            }
        }
    }
}
