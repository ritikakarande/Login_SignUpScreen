//
//  SignUpViewController.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 8/25/22.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController {
    
    // button outlet for testing
    @IBOutlet weak var signUpButton: UIButton!
    // creating outlets for textfields in signup view scene
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var mobileText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var conPasswordText: UITextField!
    
    // creating an array to store coredata email attribute
    var mailArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white

        // Do any additional setup after loading the view.
    }
    static func getSignVC() -> SignUpViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signupVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        return signupVC
    }
    @IBAction func signupButtonClicked(_ sender: Any) {

        // checking input is valid or not
        if (userNameText.text?.isNameValid)! {
            if (emailText.text?.isEmailValid)! {
                if (mobileText.text?.isPhoneNumberValid)! {
                    if ((passwordText.text?.isPasswordValid)! && (passwordText.text == conPasswordText.text)) {
                        
                        let appDelegate = (UIApplication.shared.delegate) as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext
                        let employee = NSEntityDescription.insertNewObject(forEntityName: "EmployeeData", into: context) as! EmployeeData
                        
                        // checking if email already exists
                        var flag = 0
                        do {
                            let empData = try context.fetch(EmployeeData.fetchRequest())
                            
                            for data in empData{
                                let emailExist = data.empEmailId
                                
                                if(emailExist == emailText.text) {
                                    flag = 1
                                    
                                    break
                                }
                            }
                            // Same email does not exist
                            if (flag == 0) {
                                employee.empEmailId = emailText.text
                                employee.empName = userNameText.text
                                employee.empMobile = mobileText.text
                                employee.empPassword = passwordText.text
                                do{
                                    try context.save()
                                    print("Data Stored")
                                } catch {
                                    print("Can't Load")
                                }
                                let employeeTableViewController = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeTableViewController") as! EmployeeTableViewController
                                self.navigationController?.pushViewController(employeeTableViewController, animated: true)
                                
                            } else{
                                let alert = UIAlertController(title: "Not Valid", message: "Email already exists", preferredStyle: .alert)
                                
                                // add an action button
                                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in}
                                alert.addAction(okAction)
                                // showing the alert
                                self.present(alert, animated: true, completion: nil)
                            }

                                

                        } catch {
                            print("error occured")

                        }
                        
                    } else {
                        let alert = UIAlertController(title: "Not Valid", message: "Enter valid password and confirm password", preferredStyle: .alert)
                        
                        // add an action button
                        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in}
                        alert.addAction(okAction)
                        // showing the alert
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                } else {
                    let alert = UIAlertController(title: "Not Valid", message: "Enter 10-Digits Phone Number", preferredStyle: .alert)
                    
                    // add an action button
                    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in}
                    alert.addAction(okAction)
                    // showing the alert
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Not Valid", message: "Enter Valid EmailId", preferredStyle: .alert)
                
                // add an action button
                let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in}
                alert.addAction(okAction)
                // showing the alert
                self.present(alert, animated: true, completion: nil)
            }
        
        } else {
            // create an alert
            let alert = UIAlertController(title: "Not Valid", message: "Enter Valid Username", preferredStyle: .alert)
            
            // add an action button
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { UIAlertAction in}
            alert.addAction(okAction)
            
            // showing the alert
            self.present(alert, animated: true, completion: nil)
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

// creating extension and setting parameters for checking validation
extension String {
    var isPhoneNumberValid: Bool {
        do{
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count && self.count == 10
            
            } else {
                return false
            }
            
        } catch {
            return false
        }
    }
    
    var isNameValid: Bool {
        let nameTest = NSPredicate(format: "SELF MATCHES %@", "(?=.+[a-zA-Z]).{5,}$")
        return nameTest.evaluate(with: self)
    }
    
    var isEmailValid: Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z.-]+@[a-zA-Z.-]+\\.[A-Za-z]{2,3}")
        return emailTest.evaluate(with: self)
    }
    
    var isPasswordValid: Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.+[a-zA-Z0-9_]).{6}$")
        return passwordTest.evaluate(with: self)
    }
}
