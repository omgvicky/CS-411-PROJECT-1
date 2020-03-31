//
//  noteTableViewController.swift
//  Starfit
//
//  Created by Cindy Quach and Victoria Tran on 3/29/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit
import CoreData


//Table View Controller file
class noteTableViewController: UITableViewController {

    var note_entries = [Note]()
    
    var managedObjectContext: NSManagedObjectContext? {
        return (UIApplication.shared.delegate as! AppDelegate).pContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveNotes()
        
        
   //TABLE BACKGROUND COLOR
        self.tableView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 242.0/255.0, alpha: 1.0)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        retrieveNotes()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return note_entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteTableViewCell", for: indexPath) as! noteTableViewCell

        let note: Note = note_entries[indexPath.row]
        cell.configureCell(note: note)
        cell.backgroundColor = UIColor.clear
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {

        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "                    ") { (action, indexPath) in
            
            let note = self.note_entries[indexPath.row]
            context.delete(note)
            
            (UIApplication.shared.delegate as! AppDelegate).saveStuff()
            do {
                self.note_entries = try context.fetch(Note.fetchRequest())
            }
                
            catch {
                print("Failed to delete note.")
            }
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
        delete.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "trashIcon"))
        return [delete]
    }
    
    func retrieveNotes() {
        managedObjectContext?.perform {
            
            self.fetchNotesFromCoreData { (notes) in
                if let notes = notes {
                    self.note_entries = notes
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func fetchNotesFromCoreData(completion: @escaping ([Note]?)->Void){
        managedObjectContext?.perform {
            var notes = [Note]()
            let request: NSFetchRequest<Note> = Note.fetchRequest()
            
            do {
                notes = try  self.managedObjectContext!.fetch(request)
                completion(notes)
            }
            catch {
                print("Could not fetch notes from CoreData:\(error.localizedDescription)")
            }
        }
    }

//Prepares for next screen based off selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                
                let noteDetailsViewController = segue.destination as! noteViewController
                let selectedNote: Note = note_entries[indexPath.row]
                
                noteDetailsViewController.indexPath = indexPath.row
                noteDetailsViewController.isExsisting = false
                noteDetailsViewController.note = selectedNote
            }
        }
        else if segue.identifier == "addItem" {
            print("User added a new note.")
        }
    }
}
