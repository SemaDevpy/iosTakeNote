//
//  ViewController.swift
//  TakeNote
//
//  Created by Syimyk on 11/22/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CategoryViewController: UITableViewController, SwipeTableViewCellDelegate {

    let realm = try! Realm()
    
    var categories : Results<Category>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - Adding new category(Create in CRUD)
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add a new category", style: .default) { (alertAtion) in
            let newCategory = Category()
            newCategory.name = textField.text!
            self.save(category: newCategory)
            self.tableView.reloadData()
        }
        
        alert.addTextField { (innerTextField) in
            textField = innerTextField
            textField.placeholder = "Enter a new category"
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    //MARK: - TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.firstCell, for: indexPath)  as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = categories?[indexPath.row].name ?? "no category added yet"
        return cell
    }
    
    //Delete in CRUD
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
           let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            if let categoryForDeletion = self.categories?[indexPath.row]{
                do{
                    try self.realm.write{
                        self.realm.delete(categoryForDeletion)
                    }
                }catch{
                    print("errror in deleting category object \(error)")
                }
            }
            
            
           }
           return [deleteAction]
       }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .destructive
            return options
        }
    
    //MARK: - TableView Delegate Methods
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: K.segue, sender: self)
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destinationVC = segue.destination as! NoteViewController
//        if let indexPath = tableView.indexPathForSelectedRow{
//            destinationVC.selectedCategory = categories[indexPath.row]
//        }
//
//    }
    
    //MARK: - Data Manupulation Methods
    func save(category : Category){
        
        do{
            try realm.write{
                realm.add(category)
            }
        }catch{
            print("Error in saving category \(error)")
        }
        
        
        tableView.reloadData()
    }
    
    //Read in CRUD
    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
}

