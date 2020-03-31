//
//  noteTableViewCell.swift
//  Starfit
//
//  Created by Cindy Quach and Victoria Tran on 3/29/20.
//  Copyright © 2020 Apple Developer. All rights reserved.
//

import UIKit


//THE CELLS IN THE TABLE
class noteTableViewCell: UITableViewCell {

    @IBOutlet weak var entryShadow: UIView!
    @IBOutlet weak var nameOfentry: UILabel!
    @IBOutlet weak var entryDescriptionLbl: UILabel!
    @IBOutlet weak var noteImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()

        //Shadow
        entryShadow.layer.shadowRadius = 1.5
        entryShadow.layer.cornerRadius = 2
        entryShadow.layer.shadowOpacity = 0.2
        entryShadow.layer.shadowColor =
            UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        entryShadow.layer.shadowOffset = CGSize(width: 0.75, height: 0.75)
        noteImage.layer.cornerRadius = 2
        
    }

    //Sets the selected state of the cell and animates the transition between states.
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Creates new cell for a new note
    func configureCell(note: Note) {
       
        //Sets Image
        self.noteImage.image = UIImage(data: note.noteImage! as Data)
        //Sets Name of Journal Entry
        self.nameOfentry.text = note.noteName?.uppercased()
        //Sets Description
        self.entryDescriptionLbl.text = note.noteDescription
       
    }

}
