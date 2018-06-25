//
//  AppDelegate.swift
//  Timer
//
//  Created by hetao on 2018/6/6.
//  Copyright © 2018 hetao. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    public var isRunning: Bool?
    
    // Time IO
    public func saveDateAfterSecend(_ aSecend: NSInteger) {
        if aSecend <= 0 {
            print("Warning: saveDateAfterSecend:\(aSecend)")
            return
        }
        let tSecond = (TimeInterval)(aSecend)
        let date = Date(timeIntervalSinceNow: tSecond)
        // Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss zz"
        let dateString = dateFormatter.string(from: date)
        // 持久化
        let defaultStand = UserDefaults.standard
        defaultStand.set(dateString, forKey: "TimerDateKey")
        
        // 通知
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        let content = UNMutableNotificationContent()
        content.title = "Wake up!"
        content.subtitle = ""
        content.body = "Timer has run out"//内容
//        content.badge = 1
        content.sound = UNNotificationSound(named: "meiXinMeiFei.aiff")
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: tSecond, repeats: false)
        let request = UNNotificationRequest.init(identifier: "LocalNotificationKey", content: content, trigger: trigger)
        center.add(request)
    }
    
    public func getSecend() -> NSInteger{
        // 读取
        let defaultStand = UserDefaults.standard
        let dateString = defaultStand.string(forKey: "TimerDateKey")
        // Formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss zz"
        let date = dateFormatter.date(from: dateString!)
        let aSecend = (date?.timeIntervalSinceNow)! + 1;
        if (aSecend < 0) {
            print("Warning: getSecend:\(aSecend)")
            return 0
        }
        return (NSInteger)(aSecend)
    }
    
    @objc func registerLocal() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self;
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("UNUserNotificationCenter Yay!")
            } else {
                print("UNUserNotificationCenter D'oh")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.registerLocal()
        
        return true
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
        
        UIApplication.shared.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //在应用内展示通知
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Update the app interface directly.
        let content = notification.request.content
        print("willPresent notification content:\(content)")
        
        // Play a sound.
        completionHandler([UNNotificationPresentationOptions.sound, UNNotificationPresentationOptions.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.content.categoryIdentifier == "TIMER_EXPIRED" {
            // Handle the actions for the expired timer.
            if response.actionIdentifier == "SNOOZE_ACTION" {
                // Invalidate the old timer and create a new one. . .
            }
            else if response.actionIdentifier == "STOP_ACTION" {
                // Invalidate the timer. . .
            }
        }
        
        // Else handle actions for other notification types. . .
    }
}

