//
//  NoteViewController.swift
//  TakeNote
//
//  Created by Syimyk on 11/23/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class NoteViewController: UITableViewController, SwipeTableViewCellDelegate{
    
    let realm = try! Realm()
    
    var notes : Results<Note>?
    
    var selectedCategory : Category? {
        didSet{
            loadNotes()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadNotes()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    //MARK: - Creating new note(Create in CRUD)
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.secondSegue, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.secondSegue{
            let destinationVC = segue.destination as! AddViewController
            destinationVC.selectedCategory = selectedCategory
        }else{
            let destinationVC = segue.destination as! UpdateViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.selectedCategory = selectedCategory
                destinationVC.titleOfNote = notes?[indexPath.row].title
                destinationVC.bodyOfNote = notes?[indexPath.row].body
            }
        }
    }
    
    
    
    // MARK: - Table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.secondCell, for: indexPath) as! SwipeTableViewCell
        cell.delegate = self
        cell.textLabel?.text = "Title: \(notes?[indexPath.row].title ?? "note not added yet")"
        return cell
    }
    
    
    
    //MARK: - Delete in CRUD
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            if let noteForDeletion = self.notes?[indexPath.row]{
                do{
                    try self.realm.write{
                        self.realm.delete(noteForDeletion)
                    }
                }catch{
                    print("error in deleting the note\(error)")
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
    
    
    //MARK: - TableView Delegate Methods, Update in CRUD
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.thirdSegue, sender: self)
        
    }
    
    
    //MARK: - Model manupulation methods, Read in CRUD    
    func loadNotes(){
        notes = selectedCategory?.notes.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
}


    //MARK: - Searching Functionality
extension NoteViewController : UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        notes = selectedCategory?.notes.filter("title CONTAINS[cd] %@" , searchBar.text!)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0{
            loadNotes()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }

}
