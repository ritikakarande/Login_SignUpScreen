//
//  ForgetPassViewController.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 8/30/22.
//

import UIKit

class ForgetPassViewController: UIViewController {
    
    @IBOutlet weak var resetPass: UILabel!
    var emailIdValue: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPass.text = emailIdValue
        // Do any additional setup after loading the view.
        if let receiveData = emailIdValue{
            resetPass.text = emailIdValue
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
