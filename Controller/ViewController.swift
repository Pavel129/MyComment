//
//  ViewController.swift
//  MyComment
//
//  Created by Pavel Ch.V.
//  Copyright © 2019 Pavel Ch.V.. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource
{
    var commentList: [Comment]!
    let dateFormatter = DateFormatter()
    var contex: NSManagedObjectContext!
    var sorted: [String] = []
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var putchLabel: UILabel!
    
    let pathForData:String? = {
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths[0] as! NSString
        let path = documentsDirectory.appendingPathComponent("Data.plist")
        let fileManager = FileManager.default
        //check if file exists
        if(!fileManager.fileExists(atPath: path)) {
            // If it doesn't, copy it from the default file in the Bundle
            if let bundlePath = Bundle.main.path(forResource: "Data", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                do {
                    //Copy the Database file to the Cache folder
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
                } catch {}
                
            } else {
                //  EVLog("AppSettings.plist not found. Please, make sure it is part of the bundle.")
            }
        } else {
            //   EVLog("AppSettings.plist already exits at path.")
        }
        
        return path
    }()
    
    func initData() {
        let com1 = addComment(name: "привет как дела", date: Date())
        let com2 = addComment(name: "сегодня отличная погода", date: Date())
        let com3 = addComment(name: "завтра будет солнечная погода", date: Date())
        let com4 = addComment(name: "на следующей недели обещали снег", date: Date())
    }
    
    func getAllComment() -> [Comment] {
        let sort = NSSortDescriptor(key: "date", ascending: false)
        var fetchRequest: NSFetchRequest<Comment> = Comment.fetchRequest()
        fetchRequest.sortDescriptors = [sort]
        let list: [Comment]
        do{
            list = try contex.fetch(fetchRequest)
        } catch {
            fatalError("Fetching Failed")
        }
        return list
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        commentList = getAllComment()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("appDelegate error")
        }
        contex = appDelegate.persistentContainer.viewContext
        putchLabel.text = pathForData
        print(putchLabel.text)
        
        // Register the table view cell class and its reuse id
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
    }
    
    func addComment(name: String, date: Date) -> Comment {
        let comment = Comment(context: contex)
        comment.nemsComment = name
        comment.date = date
        
        do{
            try contex.save() // сохраняем комментарий
        } catch let error as NSError {
            print ("Could not save. \(error)")
        }
        
        return comment
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "identy", for: indexPath) as? ListCommentsTableViewCell else {
            fatalError("cell type")
        }
        let task = commentList[indexPath.row]
        cell.commentTextLabel.text = task.nemsComment
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        cell.date.text = " \(dateFormatter.string(from: task.date! as Date))"
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Вы нажали на - \(indexPath.row).")
    }
    
    // setting the row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    @IBAction func receiveButtonInsert(_ sender: UIButton) {
        commentList = getAllComment()
        self.tableView.reloadData()
    }
    
    @IBAction func sendButtonInsert(_ sender: UIButton) {
        
        if textField.text == "" {
            print("Вы ничего не ввели")
            return
        }
        do {
            try contex.save()
            addComment(name: textField.text!, date: NSDate() as Date)
        } catch  {
            print(error.localizedDescription)
        }
        textField.text = ""
    }
}


