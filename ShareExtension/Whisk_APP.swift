//
//  SwiftUI_with_Share_extension_2App.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 10/29/22.
//

import SwiftUI
import Firebase
@main
struct Whisk_APP: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            //HomeView()
        SplashScreen()
            
        }
    }
}

//MARK: Setting Up Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    //required as OTP needs Remote Notification
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
        return .noData
    }
    
}
