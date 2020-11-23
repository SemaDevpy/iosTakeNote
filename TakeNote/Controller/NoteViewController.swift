//
//  NoteViewController.swift
//  TakeNote
//
//  Created by Syimyk on 11/23/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import CoreData

class NoteViewController: UITableViewController {

    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notesArray = [Note]()
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
        let destinationVC = segue.destination as! AddViewController
        destinationVC.selectedCategory = selectedCategory
    }
    
    // MARK: - Table view data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.secondCell, for: indexPath)
        cell.textLabel?.text = notesArray[indexPath.row].title
        return cell
    }

    
    //MARK: - Model manupulation methods
    func loadNotes(){
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        request.predicate = categoryPredicate
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do{
            notesArray = try context.fetch(request)
        }catch{
            print("error in fetching the data \(error)")
        }
        tableView.reloadData()
    }

}

