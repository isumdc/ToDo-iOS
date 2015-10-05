//
//  ViewController.swift
//  ToDo
//
//  Created by Ian McDowell on 9/28/15.
//  Copyright © 2015 Ian McDowell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items = Array<String>()

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        items.append("Test")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoItemCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = items[indexPath.row]
        
        return cell
    }
    
    @IBAction func plusButtonPressed(sender: AnyObject) {
        let dialog = UIAlertController(title: "New Item", message: "What should your ToDo be called?", preferredStyle: UIAlertControllerStyle.Alert);
        
        var textField: UITextField!
        
        dialog.addTextFieldWithConfigurationHandler { (field) -> Void in
            field.placeholder = "ToDo name"
            textField = field
        }
        
        dialog.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            print("OK button pressed \(textField.text!)")
            
            self.items.append(textField.text!)
            self.tableView.reloadData()
        }))
        
        dialog.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            print("Cancel button pressed")
            
        }))
        
        self.presentViewController(dialog, animated: true, completion: nil);
    }


}

