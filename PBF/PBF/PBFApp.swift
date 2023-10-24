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
    
    @StateObject var vm = ViewModel()
    @StateObject var dataController = DataController()
    
    //Coisas do FireBase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            CreateClientAccountView(context: dataController.container.viewContext)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(vm)
        }
    }
}
