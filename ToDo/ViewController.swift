//
//  ViewController.swift
//  ToDo
//
//  Created by Ian McDowell on 9/28/15.
//  Copyright © 2015 Ian McDowell. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItems() -> Array<String> {
        let defaults = NSUserDefaults.standardUserDefaults()
        var items = defaults.objectForKey("items") as? Array<String>
        if (items == nil) {
            items = Array<String>()
            defaults.setObject(items, forKey: "items")
        }
        return items!
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getItems().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoItemCell", forIndexPath: indexPath)
        
        cell.textLabel!.text = getItems()[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == .Delete) {
            var items = getItems()
            items.removeAtIndex(indexPath.row)
            NSUserDefaults.standardUserDefaults().setObject(items, forKey: "items")
            tableView.reloadData()
        }
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
            
            
            let defaults = NSUserDefaults.standardUserDefaults()
            var currentItems = defaults.objectForKey("items") as? Array<String>
            if (currentItems == nil) {
                currentItems = Array<String>()
            }
            currentItems!.append(textField.text!)
            
            defaults.setObject(currentItems, forKey: "items")

            self.tableView.reloadData()
        }))
        
        dialog.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            print("Cancel button pressed")
            
        }))
        
        self.presentViewController(dialog, animated: true, completion: nil);
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let indexPath = self.tableView.indexPathForSelectedRow!
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.todoItem = self.getItems()[indexPath.row]
    }

}

