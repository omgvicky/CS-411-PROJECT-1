//
//  ViewController.swift
//  Starfit
//
//  Created by Cindy Quach and Victoria Tran on 3/29/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit
import CoreData

//Notes View Controller
class noteViewController: UIViewController, UITextFieldDelegate,  UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var entryInfo_View: UIView!
    @IBOutlet weak var entryImg_view: UIView!
    
    @IBOutlet weak var entryName_Label: UITextField!
    @IBOutlet weak var entryDesc_label: UITextView!
    
    @IBOutlet weak var entryImg_ImageView: UIImageView!
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).pContainer.viewContext
    }

    var entry_fetchResults: NSFetchedResultsController<Note>!
    var notes = [Note]()
    var note: Note?
    var isExsisting = false
    var indexPath: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//SHOW ENTRY
        if let note = note {
            entryName_Label.text = note.noteName
            entryDesc_label.text = note.noteDescription
            entryImg_ImageView.image = UIImage(data: note.noteImage! as Data)
        }
        
        if entryName_Label.text != "" {
            isExsisting = true
        }
        
        entryDesc_label.delegate = self
        entryName_Label.delegate = self
       
        
//JOURNAL ENTRY INFO VIEW SHADOW
        
        entryInfo_View.layer.shadowRadius = 1.5
        entryInfo_View.layer.shadowOpacity = 0.2
        entryInfo_View.layer.cornerRadius = 2
        
        //SHADOW COLOR
        entryInfo_View.layer.shadowColor =
            UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        entryInfo_View.layer.shadowOffset =
            CGSize(width: 0.75, height: 0.75)
    
//JOURNAL ENTRY IMAGE VIEW SHADOW
        entryImg_view.layer.shadowRadius = 1.5
        entryImg_view.layer.shadowOpacity = 0.2
        entryImg_view.layer.cornerRadius = 2
        
        //SHADOW COLOR
        entryImg_view.layer.shadowColor =
            UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        entryImg_view.layer.shadowOffset =
            CGSize(width: 0.75, height: 0.75)
       
        entryImg_ImageView.layer.cornerRadius = 2
        entryName_Label.bottomLine()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // SAVING TO CORE DATA
    func saveToCoreData(completion: @escaping ()->Void){
        managedObjectContext!.perform {
            do {
                try self.managedObjectContext?.save()
                completion()
                print("Saved to CoreData.")
            }
            catch let error {
                print("ERROR: UNABLE to save entry to CoreData: \(error.localizedDescription)")
            }
        }
    }
    
//IMAGE PICKER: Function that has picking option for  users to add/select an image
    @IBAction func chooseImageButton_pressed(_ sender: Any) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        //ALLOWS USER TO CANCEL OPTION TO CHOOSE IMG
               let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        
        //IMAGE ALERT TO CHOOSE AN IMAGE FROM
        let alertController = UIAlertController(title: "Add an Image", message: "Choose From", preferredStyle: .actionSheet)
        
        
        //ALLOWS USER TO PICK IMG FROM PHOTO LIBRARY ON DEVICE
        let photosLibraryAction = UIAlertAction(title: "Photos Library", style: .default) { (action) in
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
        
        //ALLOWS USER TO PICK CAMERA OPTION
               let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                   pickerController.sourceType = .camera
                   self.present(pickerController, animated: true, completion: nil)
               }
        
        //ALLOWS USER TO PICK FROM THE SAVED PHOTOS ALBUM
        let savedPhotosAction = UIAlertAction(title: "Saved Photos Album", style: .default) { (action) in
            pickerController.sourceType = .savedPhotosAlbum
            self.present(pickerController, animated: true, completion: nil)
        }
        
        alertController.addAction(cameraAction)
        alertController.addAction(photosLibraryAction)
        alertController.addAction(savedPhotosAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
//IMAGE PICKER: SETTING PICKED IMAGE
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.entryImg_ImageView.image = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

//SAVE ENTRY
    @IBAction func saveBtn_pressed(_ sender: UIBarButtonItem) {
        
        if entryName_Label.text == "" || entryName_Label.text == "NOTE NAME" || entryDesc_label.text == "" || entryDesc_label.text == "Note Description..." {
            
            //ALERTS USER IF ANY FIELDS ARE EMPTY
            let alertController =
                UIAlertController(title: "Missing Information", message:"Some fields are empty. Please check that all fields are filled before saving.", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction =
                UIAlertAction(title: "Got it!", style: UIAlertActionStyle.default, handler: nil)
            
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
            if (isExsisting == false) {
                let noteName = entryName_Label.text
                let noteDescription = entryDesc_label.text
                
                if let managed_OC = managedObjectContext {
                    let note = Note(context: managed_OC)

                    if let data = UIImageJPEGRepresentation(self.entryImg_ImageView.image!, 1.0) {
                        note.noteImage = data as NSData as Data
                    }
                
                    note.noteName = noteName
                    note.noteDescription = noteDescription
    
                    saveToCoreData() {
            
                        let currentPresentingVC = self.presentingViewController is UINavigationController
                        
                        //ADDING ANIMATION TO CURRENT VIEW CONTROLLER
                        if currentPresentingVC {
                            self.dismiss(animated: true, completion: nil)
                        }

                        else {
                            self.navigationController!.popViewController(animated: true)
                        }
                    }
                }
            }
            
            else if (isExsisting == true) {
                
                let note = self.note
                
                let managedObject = note
                managedObject!.setValue(entryName_Label.text, forKey: "noteName")
                managedObject!.setValue(entryDesc_label.text, forKey: "noteDescription")
                
                if let data = UIImageJPEGRepresentation(self.entryImg_ImageView.image!, 1.0) {
                    managedObject!.setValue(data, forKey: "noteImage")
                }
                
                do {
                    try context.save()
                    
                    let currentPresentingVC = self.presentingViewController is UINavigationController
                    
                    if currentPresentingVC {
                        self.dismiss(animated: true, completion: nil)
                    }
                        
                    else {
                        self.navigationController!.popViewController(animated: true)
                    }
                }
                catch {
                    print("Error: Failed to update existing entry.")
                }
            }
        }
    }
    
// CANCEL BUTTON FUNCTION
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let currentPresentingVC = presentingViewController is UINavigationController
        
        if currentPresentingVC {
            dismiss(animated: true, completion: nil)
        }
        else {
            navigationController!.popViewController(animated: true)
        }
    }
    
//TEXT FIELD SHOULD RETURN
//Asks the delegate if the text field should process the press of the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    //PROMPTS DELEGATE THAT THE USER HAS BEGUN EDITING SPECIFIED TEXT VIEW
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Note Description...") {
            textView.text = ""
        }
    }
}

extension UITextField {
    func bottomLine() {
        
        self.borderStyle = .none
        
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        
        self.layer.masksToBounds = false
        self.layer.shadowColor =
            UIColor(red: 255.0/255.0, green: 230.0/255.0, blue: 165.0/255.0, alpha: 1.0).cgColor
        self.layer.shadowOffset =
            CGSize(width: 0.0, height: 2.0)
    }
}
