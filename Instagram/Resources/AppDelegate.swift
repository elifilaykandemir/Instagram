//
//  AppDelegate.swift
//  Instagram
//
//  Created by Elif İlay Eser
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        ///Dummy notification for the account
        ///Add dummy notification for current user
        let id = NotificationsManager.newIdentifier()
        let model = IGNotification(
            identifer: id,
            notificationType: 2,
            profilePictureUrl: "https://iosacademy.io/assets/images/brand/icon.jpg",
            username: "elanmusk",
            dateString: String.date(from: Date()) ?? "Now",
            isFollowing: false,
            postId: "123",
            postUrl:"https://iosacademy.io/assets/images/courses/swiftui.png"
        )
        NotificationsManager.shared.create(notification: model, for: "kanyewest")
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

