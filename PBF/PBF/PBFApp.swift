//
//  PBFApp.swift
//  PBF
//
//  Created by Gabriel Vicentin Negro on 13/09/23.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct PBFApp: App {
    
    //Coisas do FireBase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            Teste()
                .environmentObject(vm)
        }
    }
}
