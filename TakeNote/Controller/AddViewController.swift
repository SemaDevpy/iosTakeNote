//
//  AddViewController.swift
//  TakeNote
//
//  Created by Syimyk on 11/23/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    var selectedCategory : Category?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    @IBOutlet weak var titleNote: UITextField!
    @IBOutlet weak var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //Create of CRUD
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let newNote = Note(context: context)
        newNote.title = titleNote.text
        newNote.body = body.text
        newNote.date = Date()
        newNote.parentCategory = selectedCategory
        saveNote()
        navigationController?.popViewController(animated: true)
        
    }
    


    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Model manupulation methods
       func saveNote(){
           do {
               try context.save()
           }catch{
               print("Error saving context \(error)")
           }
       }
    
}
