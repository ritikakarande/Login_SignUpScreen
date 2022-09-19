//
//  NetworkCallViewController.swift
//  Sprint1
//
//  Created by Capgemini-DA087 on 8/31/22.
//

import UIKit

class userTableView : UITableViewCell{
    

    @IBOutlet weak var dataLabel: UILabel!
    
}
struct Book{
    var bookTitle: String
}
class NetworkCallViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    

    @IBOutlet weak var userTableView: UITableView!
    var emailArray = NSMutableArray()
    var flag = 0
    var books : [Book] = []
    var elementName: String = String()
    var bookTitle = String()
 
    
    @IBAction func booksClicked(_ sender: Any) {
        flag = 1
        if let path = Bundle.main.url(forResource: "Books", withExtension: "xml"){
            if let parser = XMLParser(contentsOf: path){
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI namesspaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]){
        if elementName == "book"{
            bookTitle = String()
        }
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "book"{
            let book = Book(bookTitle: bookTitle)
            books.append(book)
        }
        DispatchQueue.main.async {
            self.userTableView.delegate = self
            self.userTableView.dataSource = self
            self.userTableView.reloadData()
        }
        
    }
    func parser(_ parser: XMLParser, foundCharacters String: String) {
        let data = String.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if (!data.isEmpty){
            if self.elementName == "title"{
                bookTitle += data
            }

        }
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (flag == 0){
        return emailArray.count
        }else {
            return books.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.userTableView.dequeueReusableCell(withIdentifier: "userTableView", for: indexPath) as! userTableView
        if (flag == 0){
            cell.dataLabel.text = (emailArray[indexPath.row] as AnyObject) as? String
            
        }
        else {
        let book = books[indexPath.row]
        cell.dataLabel?.text = book.bookTitle
        }
        return cell
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func networkCallClicked(_ sender: Any) {
        
        flag = 0
        let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
            
        }()
        
        let request : URLRequest = {
           let url = URL (string: "https://jsonplaceholder.typicode.com/posts/1/comments")
           let request = URLRequest(url: url!)
            return request
        }()
        
        let dataTask = session.dataTask(with: request){ [self] (data, response, error) in
            
            if let _ = data{
                do{
                    
                    let json = try JSONSerialization.jsonObject(with: data! , options: []) as! [[String: AnyObject]]
                    print(json)
                    
                    for item in json {
                        let emailStr = item["email"] as! String
                        emailArray.add(emailStr)
                    }
                    DispatchQueue.main.async {
                        self.userTableView.delegate = self
                        self.userTableView.dataSource = self
                        self.userTableView.reloadData()
                    
                    }

            }
                catch let error as NSError{
                    print("error occured : \(error.localizedDescription)")
                }
        }
       
    }
    dataTask.resume()    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
