//
//  UpdateViewController.swift
//  TakeNote
//
//  Created by Syimyk on 11/24/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import RealmSwift

class UpdateViewController: UIViewController {
    
    let realm = try! Realm()
    
    var selectedCategory : Category?
    var titleOfNote : String?
    var bodyOfNote : String?
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = titleOfNote!
        textView.text = bodyOfNote!
    }
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        
        if let saveCategory = selectedCategory{
            
            do{
                try realm.write{
                    let note = saveCategory.notes.filter("title == %@", titleOfNote!)
                    note[0].title = titleTextField.text!
                    note[0].body = textView.text
                    navigationController?.popViewController(animated: true)
                }
            }catch{
                print("error in updating the note")
            }
            
        }
        
        
        
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
