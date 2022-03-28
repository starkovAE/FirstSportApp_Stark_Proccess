//
//  Notifications.swift
//  FirstApp_Proccess
//
//  Created by Александр Старков on 08.02.2022.
//

import Foundation
import UserNotifications
import UIKit

class Notifications: NSObject {
    let notificationCenter = UNUserNotificationCenter.current() //текущий
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in //будет вылетать алерт, звук, и иконка
            guard granted else { return } //есть ли разрешение на уведомление
            self.getNotificationSetting()
            
        }
    }
    func getNotificationSetting(){
        notificationCenter.getNotificationSettings { setting in
            print(setting)
        }
    }
    func scheduleDateNotification(date: Date, id: String) {
        let content = UNMutableNotificationContent()
        content.title = "WORKOUT"
        content.body = "Today you have traning"
        content.sound = .default
        content.badge = 1
    
//        var calendar = Calendar.current
//        calendar.timeZone = TimeZone(abbreviation: "UTC")!
//        var triggerDate = calendar.dateComponents([.year, .month, .day], from: date)

        var triggerDate = Calendar.current.dateComponents([.year, .month, .day], from: date) //дата из входных параметров
        triggerDate.hour = 14
        triggerDate.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false) //кода будет вызываться уведомление по тригер дате, без повторений
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        notificationCenter.add(request) { error in
            print("Error \(error?.localizedDescription ?? "error") ")
        }
    }
    func removeBadge() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        notificationCenter.removeAllDeliveredNotifications()
    }
}
extension Notifications: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0 //когда будет уведомление оно увеличится на 1, чтобы в этом можно было несколько уведомдений
        notificationCenter.removeAllDeliveredNotifications() //будет удалять все доставленные уведомления (чтобы не заполнять память)
    }
    
}

