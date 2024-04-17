//
//  NoteDetailViewController.swift
//  MyNews
//
//  Created by user238581 on 4/17/24.
//

import UIKit

class NoteDetailViewController: UIViewController {

    var note: Note?
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the content of the label
        if let note = note {
            titleLabel.text = note.title
            contentLabel.text = note.content
        }
    }
    
  
}
