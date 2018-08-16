//
//  AppDelegate.swift
//  Naber
//
//  Created by LianYong-Jun on 2018/5/20.
//  Copyright © 2018年 Melone.L.T.D. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase
//import FirebaseInstanceID
//import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var token: String = ""
    let USER_TYPES: [Identity] = Identity.getUserValues()
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        if UIDevice.current.model.range(of: "iPad") != nil{
//            print("I AM IPAD")
//        } else {
//            print("I AM IPHONE")
//        }
       
        
        FirebaseApp.configure()
        
        Auth.auth().signIn(withEmail: "naber_android@gmail.com", password: "melonltd1102") { (user, error) in
            print(user?.user.email ?? "")
            print(error?.localizedDescription ?? "")
        }
        
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        } else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }

    
        return true
    }
    
    // Called when APNs has assigned the device a unique token
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Convert token to string
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        
        // Print it to console
        print("APNs device token: \(deviceTokenString)")
        self.token = deviceTokenString
        // Persist it in your backend in case it's new
    }
    
    // Called when APNs failed to register the device for push notifications
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Print the error to console (you should alert the user that registration failed)
        print("APNs registration failed: \(error)")
    }
    
    
    // Push notification received
    func application(_ application: UIApplication, didReceiveRemoteNotification data: [AnyHashable : Any]) {
        // Print notification payload data
        print("Push notification received: \(data)")

    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        let currentId: Identity = UserSstorage.getCurrentId()!
        
        if let identity: Identity = Identity(rawValue: userInfo["identity"] as! String) {
            if USER_TYPES.contains(identity) && USER_TYPES.contains(currentId) {
                if UserSstorage.getSound()!{
                    completionHandler([.alert, .badge, .sound])
                }else {
                    completionHandler([.alert, .badge])
                }
            }
            
            if identity == Identity.SELLERS  && currentId == Identity.SELLERS {
                completionHandler([.alert, .badge, .sound])

            }
        }

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }

        // Print full message.
        print(userInfo)

        completionHandler()
    }
}


