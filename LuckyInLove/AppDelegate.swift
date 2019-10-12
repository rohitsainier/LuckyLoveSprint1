//
//  AppDelegate.swift
//  LuckyInLove
//
//  Created by Ruchit on 05/10/19.
//  Copyright © 2019 Ruchit. All rights reserved.
//

import UIKit
import Firebase
import FirebaseMessaging
import UserNotifications
import NVActivityIndicatorView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let gcmMessageIDKey = "gcm.message_id"
    var userFcmToken: String = ""
    var window: UIWindow?
    var customTabbarVc: CustomTabBarController!
    var activityLoader : NVActivityIndicatorView!
    var backView: UIView!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        // [END register_for_notifications]
        
        
        IQKeyboardManager.shared.enable = true

        return true
    }
    
    
    // [START receive_message]
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
            // If you are receiving a notification message while your app is in the background,
            // this callback will not be fired till the user taps on the notification launching the application.
            // TODO: Handle data of notification
            // With swizzling disabled you must let Messaging know about the message, for Analytics
            // Messaging.messaging().appDidReceiveMessage(userInfo)
            // Print message ID.
            if let messageID = userInfo[gcmMessageIDKey] {
                print("Message ID: \(messageID)")
            }
            
            // Print full message.
            print(userInfo)
            
        }
        
        func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                         fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
            // If you are receiving a notification message while your app is in the background,
            // this callback will not be fired till the user taps on the notification launching the application.
            // TODO: Handle data of notification
            // With swizzling disabled you must let Messaging know about the message, for Analytics
            // Messaging.messaging().appDidReceiveMessage(userInfo)
            // Print message ID.
            
            if let messageID = userInfo[gcmMessageIDKey] {
                print("Message ID: \(messageID)")
            }
            
            completionHandler(UIBackgroundFetchResult.newData)
        }
        // [END receive_message]
        func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
            print("Unable to register for remote notifications: \(error.localizedDescription)")
        }
        
        // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
        // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
        // the FCM registration token.
        func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
            print("APNs token retrieved: \(deviceToken)")
            
            // With swizzling disabled you must set the APNs token here.
            // Messaging.messaging().apnsToken = deviceToken
        }
        
        
        func getFcmToken() -> String
        {
            if userFcmToken == ""
            {
                if let token = Messaging.messaging().fcmToken
                {
                    userFcmToken = token
                }
            }
            return userFcmToken
        }
        
        
    
    //MARK:- Loader
    func showLoader()
    {
        removeLoader()
        window?.isUserInteractionEnabled = false
        backView = UIView(frame: (window?.frame)!)
        backView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        activityLoader = NVActivityIndicatorView(frame: CGRect(x: ((window?.frame.size.width)!-50)/2, y: ((window?.frame.size.height)!-50)/2, width: 50, height: 50))
        activityLoader.type = .ballScaleMultiple
        activityLoader.color = #colorLiteral(red: 1, green: 0, blue: 0.337254902, alpha: 1)
        backView.addSubview(activityLoader)
        window?.addSubview(backView)
        
        activityLoader.startAnimating()
    }
    
    func removeLoader()
    {
        
        window?.isUserInteractionEnabled = true
        if activityLoader == nil
        {
            return
        }
        activityLoader.stopAnimating()
        backView.removeFromSuperview()
        activityLoader = nil
    }
        
        //MARK:- Send Push Notifications
//        func sendPush(title:String, body:String, user:User, type : String,ID:String)
//        {
//            
//            let url  = NSURL(string: "https://fcm.googleapis.com/fcm/send")
//            
//            let request = NSMutableURLRequest(url: url! as URL)
//            
//            request.setValue("application/json", forHTTPHeaderField:"Content-Type")
//            request.setValue("key=AAAApfRJ8Yo:APA91bGxIhcBXb8Mzu-4QN8wpXYrQzuqdXtm2jtfRCyS_mPUkdJleSu-stRNoey5asVl8YYkkPWS_jCyHqRLo11HqlyzQuYzpK568kA2PHzzUKKVTYpEHS371vpokhr6mvk3ome-QB1P", forHTTPHeaderField: "Authorization")
//            
//            request.httpMethod = "POST"
//            
//            //badge
//            let userBadge : Int = 0
//          
//            
//            let sessionConfig = URLSessionConfiguration.default
//            
//            let token = user.fcmToken
//            let json = ["to":token,
//                        "priority":"high",
//                        "content_available":true,
//                        "mutable_content": true,
//                        "data":["type": type,"ID":ID,"payload":"sample","reference":ID],
//                        "notification":["sound" : "default", "badge" : String(userBadge), "body":body,"title":title]] as [String : Any]
//            
//            do {
//                
//                let jsonData = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
//                request.httpBody = jsonData
//                
//                let urlSession = URLSession(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue.main)
//                let datatask = urlSession.dataTask(with: request as URLRequest) { (data, response, error) in
//                    if data != nil
//                    {
//                        let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                        print("Body: \(String(describing: strData))")
//                        print(response ?? "",data ?? "")
//                        print(error ?? "")
//                        
//                    }
//                    
//                }
//                
//                datatask.resume()
//                
//            } catch let error as NSError {
//                print(error)
//            }
//            
//        }

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
    
    //MARK: - sharedDelegate
    func sharedDelegate() -> AppDelegate
    {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //MARK: - storyboard
    func storyboard() -> UIStoryboard
    {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    //MARK: - navigateToDashboard
    func navigateToDashboard()
    {
        customTabbarVc = self.storyboard().instantiateViewController(withIdentifier: "CustomTabBarController") as? CustomTabBarController
        
        if let rootNavigatioVC : UINavigationController = self.window?.rootViewController as? UINavigationController
        {
            rootNavigatioVC.pushViewController(customTabbarVc, animated: false)
        }
        
    }


}



// [START ios_10_message_handling]
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }


        // Change this to your preferred presentation option
        //if user is in chat window
//        if AppModel.shared.isInChatWindow{
//            return
//        }
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void){
        let userInfo = response.notification.request.content.userInfo
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        //  Print full message.
        
        print(userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]
extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        userFcmToken = fcmToken
////        AppModel.shared.fcmToken = userFcmToken
//        if AppModel.shared.currentUser != nil{
//            if let currentUserID = AppModel.shared.currentUser.id{
//                Database.database().reference().child("users").child(currentUserID).child("credentials").updateChildValues(["fcmToken": userFcmToken])
//                print("FCM ADDED TO FIREBASE")
//            }
//
//        }
        
//        let dataDict:[String: String] = ["token": fcmToken]
//        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
    }
    
    
    // [END ios_10_data_message]
}
