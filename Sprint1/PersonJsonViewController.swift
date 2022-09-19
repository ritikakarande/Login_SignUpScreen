//
//  PersonJsonViewController.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 9/1/22.
//

import UIKit

class PersonTV : UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
}

class PersonJsonViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var PersonTV: UITableView!
    var nameArray = NSMutableArray()
    var ageArray = NSMutableArray()
    
        
    @IBAction func personClicked(_ sender: Any) {
        
        if let path = Bundle.main.path(forResource: "Users", ofType: "json") {
            
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data , options: []) as! [String: [[String: AnyObject]]]
                print(json)
                
                nameArray = []
                ageArray = []
                
                for ( _ , value) in json {
                    
                    for item in value {
                        
                        let nameStr = item["name"] as! String
                        let ageStr = item["age"] as! String
                        nameArray.add(nameStr)
                        ageArray.add(ageStr)
                        
                    }
                }
                print(nameArray)
                        
                DispatchQueue.main.async {
                    self.PersonTV.delegate = self
                    self.PersonTV.dataSource = self
                    self.PersonTV.reloadData()
                
                }
            }
            
            catch {
                print("error occured \(error.localizedDescription)")
            }
        }
            
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.PersonTV.dequeueReusableCell(withIdentifier: "PersonTV", for: indexPath) as! PersonTV
        
        cell.nameLabel.text = (nameArray[indexPath.row] as! String)
        cell.ageLabel.text = (ageArray[indexPath.row] as! String)
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
