//
//  USNotificationHelper.swift
//  Bump
//
//  Created by Boshi Li on 2017-07-16.
//  Copyright © 2017 Boshi Li. All rights reserved.
//

import UIKit
import UserNotifications

enum AuthorizationStatus {
    case authorized
    case denied
    case notDetermined
}

final class USNotificationHelper: NSObject {
    private override init() {}
    
    static let shared = USNotificationHelper()
    
    var isRegistered: Bool {
        return UIApplication.shared.isRegisteredForRemoteNotifications
    }
    
}

// MARK: - Check Users Authorization Status
extension USNotificationHelper: UNUserNotificationCenterDelegate {
    //Register for user notiifcation
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { [weak self] (granted, error) in
            print("Permission granted: \(granted)")
            guard error != nil else {return}
            guard granted else { return }
            self?.getNotificationSettings()
        }
        
        let openAction = UNNotificationAction(identifier: "openAction", title: "檢視", options: [.foreground])
        let category = UNNotificationCategory(identifier: "category", actions: [openAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            // 確認確定後才註冊通知
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
            
        }
    }
    
    func checkSettings(_ complection: @escaping (AuthorizationStatus) -> Swift.Void) {
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.getNotificationSettings { (setting) in
                switch setting.authorizationStatus {
                    
                case .notDetermined:
                    complection(.notDetermined)
                    
                case .denied:
                    complection(.denied)
                    
                case .authorized:
                    complection(.authorized)
                }
            }
        } else {
            if (UIApplication.shared.currentUserNotificationSettings?.types) != nil {
                complection(.authorized)
            } else {
                complection(.denied)
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        var deviceToken = ""
        
        if let token = UserDefaultsHelper.deviceToken.read() as? String {
            deviceToken = token
        }else {
            deviceToken = tokenParts.joined()
            UserDefaultsHelper.deviceToken.set(deviceToken)
        }
        
        print("deviceToken:" + deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    @available(iOS 10.0, *) // 在前台接收通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert])
    }
}

// MARK: - Request again if user not determined or denied API
extension USNotificationHelper {
    func requestAuthorization(complection: @escaping (UIViewController) -> Swift.Void) {
        self.checkSettings { (status) in
            switch status {
            case .authorized:
                break
            case .notDetermined:
                self.registerForPushNotifications()
            case .denied:
                let alertController = UIAlertController(
                    title: "啟用通知被拒絕",
                    message: "請將 通知 調整到 \"允許通知\", 以提供新訊息通知。",
                    preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                let openAction = UIAlertAction(title: "開啟設定", style: .default) { _ in
                    if let url = URL(string:UIApplicationOpenSettingsURLString) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(url)
                        }
                    }
                }
                alertController.addAction(openAction)
                complection(alertController)
            }
        }
    }
}
