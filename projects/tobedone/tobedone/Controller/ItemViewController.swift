//
//  ItemViewController.swift
//  tobedone
//
//  Created by ArronStudio on 2019-07-13.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit
import RealmSwift

class ItemViewController: Swipe {
    
    let realm = try! Realm()
    var items : Results<Item>?
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = selectedCategory?.name
    }
    
    @IBAction func addItem(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "New Item", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) {
            action in
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newItem = Item()
                        newItem.name = textField.text!
                        newItem.createdAt = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error when saving category. \(error)")
                }
                self.tableView.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alert.addTextField {
            alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - delete item
    override func updateModel(at indexPath: IndexPath) {
        if let selectedItem = items?[indexPath.row] {
            do {
                try self.realm.write {
                    self.realm.delete(selectedItem)
                }
            } catch {
                print("Item deletion failed. \(error)")
            }
            tableView.reloadData()
        }
    }
    
    //MARK: - Load items
    func loadItems () {
        items = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
    }

    //MARK: - Table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = "No items added"
        guard let item = items?[indexPath.row] else { fatalError() }
        cell.textLabel?.text = item.name
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedItem = items?[indexPath.row] {
            do {
                try self.realm.write {
                    selectedItem.done = !selectedItem.done
                }
            } catch {
                print("Error saving item state. \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
