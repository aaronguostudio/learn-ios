//
//  CategoryViewController.swift
//  todoey
//
//  Created by ArronStudio on 2019-07-07.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categoryArray : Results<Category>?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Category", style: .default) {
            action in
            if (textField.text ?? "").isEmpty {
                return
            }
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.saveCategory(category: newCategory)
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        // let item = categoryArray[indexPath.row]
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No category yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Nil Coalescing Operator
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    // this will be triggered after performSegue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC  = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }
    
    //MARK - add new item
    
    
    //MARK - save item
    func saveCategory (category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error when save item, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    //MARK - load item
    func loadCategories () {
        categoryArray = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
}
