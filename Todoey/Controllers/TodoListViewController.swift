//
//  ViewController.swift
//  Todoey
//
//  Created by Christian Harrison on 03/07/2018.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        print(dataFilePath)
    
        loadItems()
        
    }
 
    //MARK - Tableview Datasource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        //populates cell with appropriate text
        cell.textLabel?.text = item.title
        
        // Set the cell accessory to checkmark if done = true, .none if done = false.
        cell.accessoryType = item.done ? .checkmark : .none
      
        
        return cell
        
    }
    
    //MARK - table view delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  print(itemArray[indexPath.row])
        
        // sets done property of item array to the oposite of it's current property
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
         self.saveItems()
        
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
            let newItem = Item()
            
            newItem.title = textField.text! 
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            print(alertTextField.text)
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func saveItems() {
        
            let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
           let decoder = PropertyListDecoder()
            do {
            itemArray =  try decoder.decode([Item].self, from: data)
            }catch {
                print("error in decoding data, \(error)")
            }
        }
    }
}






















