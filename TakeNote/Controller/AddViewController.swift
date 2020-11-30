//
//  AddViewController.swift
//  TakeNote
//
//  Created by Syimyk on 11/23/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {
    
    let realm = try! Realm()
    
    var notes : Results<Note>?
    
    var selectedCategory : Category?


    
    @IBOutlet weak var titleNote: UITextField!
    @IBOutlet weak var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Create of CRUD
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        do{
            try realm.write{
                let newNote = Note()
                newNote.title = titleNote.text!
                newNote.body = body.text
                selectedCategory?.notes.append(newNote)
                navigationController?.popViewController(animated: true)
            }
        }catch{
            print("error adding note \(error)")
        }
        
        
        
        
    }
    


    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Model manupulation methods
//    func saveNote(note : Note){
//           do {
//            try realm.write{
//                realm.add(note)
//            }
//           }catch{
//               print("Error saving the note\(error)")
//           }
//       }
    
    
    
//    func loadNote(){
//         let request : NSFetchRequest<Note> = Note.fetchRequest()
//         let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
//         request.predicate = categoryPredicate
//
//     }
}
