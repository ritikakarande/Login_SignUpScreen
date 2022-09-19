//
//  ViewController.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 8/25/22.
//
import Foundation
import UIKit
import CoreData
import LocalAuthentication

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginButton: UIButton! // for testing
    @IBOutlet weak var emailIdText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    var emailArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Local Notification Demo
        authenticateUserBySecurityPin()
        //authenticateUserByFaceId()
    
    }
    
    // Function for implementig security after launching app
    func authenticateUserBySecurityPin(){
        let context: LAContext = LAContext()
        let msgStr = "Authentication is needed to access your App"
        var authError: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError){
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: msgStr, reply: {success, error in
                if success {
                    print("Authentication successful")
                }
                
                else {
                    if let error = error{
                        let message = self.showMessageWithErrorCode(errorcode: (error as! Int))
                        //let message = self.showMessageWithErrorCode(errorcode: -2)
                        print(message)
                       // print(error.localizedDescription)
                    
                        
                    }
                }
                
            })
        }
    }
    // error function called in authenticating user by touchId
    func showMessageWithErrorCode(errorcode: Int) -> String {
        var messageStr = ""
        switch errorcode{
        case LAError.appCancel.rawValue:
            messageStr = "Authentication was cancelled by App"
        case LAError.authenticationFailed.rawValue:
            messageStr = "Unable to authenticate user"
        default:
            messageStr = "Common error"
        }
        return messageStr
    }
    
    // Security function - access using face id
    func authenticateUserByFaceId(){
        let context = LAContext()
        var autherror: NSError?
        let msgStr = "Authentication required"
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &autherror){
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: msgStr) {
                [weak self] success, error in
                DispatchQueue.main.async {
                    if success{
                        self?.presentAlert(messageStr: "Authentication Successful", title: "Success")
                    }
                    else {
                        
                    }
                }
            }
        }
        else{
            presentAlert(messageStr: "Biometric authentication not available", title: "Failed")
        }
    }
    
    func presentAlert (messageStr: String, title: String){
        let alert = UIAlertController(title: title, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    static func getVC() -> LoginViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        return VC
    }
    
    
    // creating function for login button when clicked
    @IBAction func loginClicked(_ sender: Any) {
        
        let mail = emailIdText.text!
        let password = passwordText.text!
        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // creating a flag for condition
        var flag = 0
        do{
            let dataResults = try context.fetch(EmployeeData.fetchRequest())
            
            for data in dataResults {
                let emailExist = data.empEmailId
                let passwordExist = data.empPassword
                if(emailExist == mail && passwordExist == password){
                    flag = 1
                    break
                }
            }
        } catch {
        print("error")
        }
        
        if(flag == 1){
            
                // go to employee table view
                let employeeTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeTableViewController") as! EmployeeTableViewController
                self.navigationController?.pushViewController(employeeTableViewController, animated: true)
            
        } else {
            // create an alert
            let alert = UIAlertController(title: "Not Found", message: "User does not exist. Please SignUp", preferredStyle: .alert)
            
            // add an action button
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in}
            alert.addAction(okAction)
            // showing the alert
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func forgetPass(_ sender: Any) {
        let forgetPassVC = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPassViewController") as! ForgetPassViewController
        
        forgetPassVC.emailIdValue = "Reset password for " + emailIdText.text!
        self.navigationController?.pushViewController(forgetPassVC, animated: true)
    }
    
}
        
