//
//  ViewController.swift
//  Todoey
//
//  Created by Christian Harrison on 03/07/2018.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Berries", "Avocado", "Eggs"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
 
    //MARK - Tableview Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        //populates cell with appropriate text
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
        
    }
    
    //MARK - table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    //MARK - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        // "{ (action) in..." is the completion block that is executed when button presed
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen once the user clickes the add item on our UI alert
        print("success!")
            
        // can force unwrap becuase the text property of a text field is never nil
            self.itemArray.append(textField.text!)
            
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            print(alertTextField.text)
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}






















