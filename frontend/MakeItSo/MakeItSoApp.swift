//
//  MakeItSoApp.swift
//  MakeItSo
//
//  Created by madeinweb on 22/07/23.
//

import SwiftUI
import Factory
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    @LazyInjected(\.authenticationService)
      private var authenticationService
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    authenticationService.signInAnonymously()
    return true
  }
}


@main
struct MakeItSoApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                RemindersListView()
                    .navigationTitle("Reminders")
            }
        }
    }
}
