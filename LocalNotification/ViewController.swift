//
//  ViewController.swift
//  LocalNotification
//
//  Created by Vaibhav Upadhyay on 10/08/20.
//  Copyright © 2020 Vaibhav Upadhyay. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

    
    let center = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Step 1 ask permission
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granded, error) in
            
        }
    }

    @IBAction func sendNotificationClick(_ sender: UIButton) {
        // step 2: Create the notification content
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "myCategoryIdentifier"
        content.title = "Hey I m a notification"
        content.body = "Look at me"
        content.badge = 1
        content.sound = .default
        //Step 3: Create the notification trigger
        let date = Date().addingTimeInterval(5)
        
        let dateComponent = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        center.removeAllPendingNotificationRequests()
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        //Step 4: Create the request
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        //Step 5: Register the request
        center.add(request) { (error) in
            //Check error
        }
        let likeAction = UNNotificationAction(identifier: "like", title: "Like", options: .foreground)
        let deleteAction = UNNotificationAction(identifier: "delete", title: "Delete", options: .destructive)
        let category = UNNotificationCategory(identifier: content.categoryIdentifier, actions: [likeAction, deleteAction], intentIdentifiers: [], options: [])
        center.setNotificationCategories(Set([category]))
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
}

