//
//  CategoryViewController.swift
//  tobedone
//
//  Created by ArronStudio on 2019-07-13.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class CategoryViewController: Swipe {
    
    let realm = try! Realm()
    var categories: Results<Category>?
    var uid: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
        } else {
            fatalError("Unauthoized")
        }
        
        loadCategories()
    }

    // MARK: - Table view
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No category created yet"
        guard let category = categories?[indexPath.row] else { fatalError() }
        cell.textLabel?.text = category.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }

    //MARK: - add category action
    @IBAction func addCategory(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Add", style: .default) {
            action in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            newCategory.uid = self.uid!
            self.saveCategory(category: newCategory)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField {
            alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(cancelAction)
        alert.addAction(addAction)
        present(alert, animated: true, completion: nil)
    }
    
    func cancelCategory () {
        
    }
    
    //MARK: - delete category
    override func updateModel(at indexPath: IndexPath) {
        
        print("delete item")
        if let selectedCategory = categories?[indexPath.row] {
            
            let alert = UIAlertController(title: "Delete this category?", message: "All items in this category will be deleted", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Confirm", style: .default) {
                action in
                do {
                    try self.realm.write {
                        self.realm.delete(selectedCategory)
                    }
                } catch {
                    print("Item deletion failed. \(error)")
                }
                self.tableView.reloadData()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: - save category
    func saveCategory (category: Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error when save category. \(error)")
        }
        
        tableView.reloadData()
    }
    
    //MARK: - load categories
    func loadCategories () {
        categories = realm.objects(Category.self).filter("uid CONTAINS[cd] %@", uid!).sorted(byKeyPath: "name")
        tableView.reloadData()
    }
}
