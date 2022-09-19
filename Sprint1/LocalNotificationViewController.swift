//
//  LocalNotificationViewController.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 9/5/22.
//

import UIKit
import UserNotifications

class LocalNotificationViewController: UIViewController {

    let notificationCenter = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationCenter.delegate = self
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.sendNotification()
        
        
        //let nc = NotificationCenter.default
        
        //nc.addObserver(self, selector: #selector(UserLogin), name: Notification.Name("UserLogin"), object: nil)
        // Do any additional setup after loading the view.
        
       // NotificationCenter.default.post(name: Notification.Name("UserLogin"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(UserLogin), name: Notification.Name("UserLogin"), object: nil)
    }
    
    func configureloginNotificationCenter(){
        UNUserNotificationCenter.current().delegate = self
        // creating two action buttons
        let notificationAction = UNNotificationAction(identifier: "reply", title: "Reply", options: UNNotificationActionOptions.init(rawValue: 0))
        let loginAction = UNNotificationAction(identifier: "mark as read", title: "Mark as read", options: UNNotificationActionOptions.init(rawValue: 0))
        // creating one single category for calling both actions
        let notificationCategory = UNNotificationCategory(identifier: "userReply", actions: [notificationAction, loginAction], intentIdentifiers: [], options: [])
        UNUserNotificationCenter.current().setNotificationCategories([notificationCategory])
        
        
    }
    
    @objc func UserLogin(_notification: Notification){
        print("UserLogin Notification")
    }
    
    func sendNotification(){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Login Notification"
        notificationContent.body = "Hello User"
        notificationContent.badge = NSNumber(value: 1)
        notificationContent.categoryIdentifier = "userReply"
        
        let loginDict: [String: String] = ["User" : "User"]
        notificationContent.userInfo = loginDict
        
        // calling action to notification
        configureloginNotificationCenter()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let requet = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)
        notificationCenter.add(requet){ (error) in
            if let error = error{
                print("notification error: ", error)
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LocalNotificationViewController: UNUserNotificationCenterDelegate {
    
    /*func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner])
    }*/
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        /*let loginInfo = response.notification.request.content.userInfo
        let checkStr = loginInfo["User"]
        
        if (checkStr as! String == "User") {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let signupVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
            self.navigationController?.pushViewController(signupVC, animated: true)
        }*/
        switch response.actionIdentifier {
        case "reply" :
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserLogin"), object: nil)
            print("Reply button clicked")
            
        case "mark as read" :
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserLogin"), object: nil)
            print("Mark as read")
            
            
        default:
            let loginInfo = response.notification.request.content.userInfo
            let checkStr = loginInfo["User"]
            
            if (checkStr as! String == "User") {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let signupVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
                self.navigationController?.pushViewController(signupVC, animated: true)
            }
        }
        completionHandler()
    }
    
}
