//
//  EmployeeViewController.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 8/30/22.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet weak var nameData: UILabel!
    @IBOutlet weak var hello: UILabel!
    var employeeName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        hello.text = "Hello"
        nameData.text = employeeName

        // Do any additional setup after loading the view.
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
