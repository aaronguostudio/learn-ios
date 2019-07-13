//
//  CategoryViewController.swift
//  tobedone
//
//  Created by ArronStudio on 2019-07-13.
//  Copyright © 2019 AaronStudio. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: Swipe {
    
    let realm = try! Realm()
    var categories: Results<Category>?

    override func viewDidLoad() {
        super.viewDidLoad()
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
            self.saveCategory(category: newCategory)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
            action in
            self.cancelCategory()
        }
        
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
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
}
