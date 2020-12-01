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
    
    var selectedCategory : Category?


    
    @IBOutlet weak var titleNote: UITextField!
    @IBOutlet weak var body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
