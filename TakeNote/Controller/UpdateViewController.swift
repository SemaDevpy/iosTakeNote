//
//  UpdateViewController.swift
//  TakeNote
//
//  Created by Syimyk on 11/24/20.
//  Copyright © 2020 Syimyk. All rights reserved.
//

import UIKit
import CoreData

class UpdateViewController: UIViewController {
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
//             let request : NSFetchRequest<Note> = Note.fetchRequest()
//             let noteTitlePredicate = NSPredicate(format: "title MATCHES %@", titleOfNote!)
//             request.predicate = noteTitlePredicate
//             do{
//                 let note = try context.fetch(request)
//                note[0].title = titleTextField.text!
//                note[0].body = textView.text
//                note[0].date = Date()
//                saveNote()
//                navigationController?.popViewController(animated: true)
//             }catch{
//                 print("error in fetching the data \(error)")
//             }
    }
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Model manupulation methods
//       func saveNote(){
//           do {
//               try context.save()
//           }catch{
//               print("Error saving context \(error)")
//           }
//       }
}
