//
//  NoteViewController.swift
//  TakeNote
//
//  Created by Syimyk on 11/23/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import CoreData
import SwipeCellKit

class NoteViewController: UITableViewController, SwipeTableViewCellDelegate{
    var notesArray = [Note]()
    var selectedCategory : Category? {
        didSet{
           // loadNotes()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //loadNotes()
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
                destinationVC.titleOfNote = notesArray[indexPath.row].title
                destinationVC.bodyOfNote = notesArray[indexPath.row].body
            }
        }
    }
    
    
    
    // MARK: - Table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.secondCell, for: indexPath) as! SwipeTableViewCell
//        cell.delegate = self
//        //cell.textLabel?.text = "Title: \(notesArray[indexPath.row].title!)"
        return cell
    }
    
    
    
    //MARK: - Delete in CRUD
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            //self.context.delete(self.notesArray[indexPath.row])
            self.notesArray.remove(at: indexPath.row)
            self.saveNote()
        }
        return [deleteAction]
    }
    
    
    
    
    //MARK: - TableView Delegate Methods, Update in CRUD
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K.thirdSegue, sender: self)
        
    }
    
    
    //MARK: - Model manupulation methods, Read in CRUD
//    func loadNotes(with request : NSFetchRequest<Note> = Note.fetchRequest(), predicate : NSPredicate? = nil){
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//        if let savePredicate = predicate{
//           let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, savePredicate])
//           request.predicate = compoundPredicate
//        }else{
//            request.predicate = categoryPredicate
//        }
//
//        do{
//            notesArray = try context.fetch(request)
//        }catch{
//            print("error in fetching the data \(error)")
//        }
//        tableView.reloadData()
//    }
    
    func saveNote(){
//        do {
//            try context.save()
//        }catch{
//            print("Error saving context \(error)")
//        }
//        tableView.reloadData()
    }
    
    
}


    //MARK: - Searching Functionality
//extension NoteViewController : UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let request : NSFetchRequest<Note> = Note.fetchRequest()
//
//        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
//
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//        loadNotes(predicate: predicate)
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text?.count == 0{
//            loadNotes()
//
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//
//        }
//    }
//
//}
