//
//  ViewController.swift
//  todoey
//
//  Created by ArronStudio on 2019-07-02.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {
    
    var todoItems : Results<Item>?
    let realm = try! Realm()
    
    // load items after selectedCategory has been set
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
//    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    // get appDelegeate instance which defined in the AppDelegate
    // context likes a staging area between app and the database
//    let context = (UIApplication.shared.delegate as! AppDelegate)
//        .persistentContainer.viewContext
    
//    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        // Do any additional setup after loading the view.
        
        
//        print("> \(dataFilePath)")
        
//        let newItem = Item()
//        newItem.title = "Hello"
//
//        itemArray.append(newItem)
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }\
        
        
  
    }
    
    //MARK - TableView delegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
       
        
        if let item = todoItems?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // remove item
//         context.delete(itemArray[indexPath.row])
//         itemArray.remove(at: indexPath.row)
        
        
        if let selectedItem = todoItems?[indexPath.row] {
            do {
                try self.realm.write {
                    selectedItem.done = !selectedItem.done
                }
            } catch {
                print("Error saving new items, \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - add new item

    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // run after click add
            print("success \(action)", (textField.text ?? "").isEmpty)
            if (textField.text ?? "").isEmpty {
                return
            }
           
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.title = textField.text!
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error saving new items, \(error)")
                }
                
            }
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
//    func loadItems () {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
            
//            do {
//                itemArray = try decoder.decode([Item].self, from: data)
                
//            } catch {
//                print("Decode error, \(error)")
//            }
//        }
//    }

    
    func loadItems () {
        
        todoItems = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
        tableView.reloadData()
    }
    
}

//MARK: - Search bar methods
extension TodoListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Item> = Item.fetchRequest()
//        let predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
        
        // query
//        request.predicate = NSPredicate(format: "title CONTAINS %@", searchBar.text!)
        
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadItems(with: request, predicate: predicate)
        print("> \(searchBar.text!)")
        
        todoItems = todoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

