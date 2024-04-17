//
//  ViewController.swift
//  MyNews
//
//  Created by user238581 on 4/17/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func newsButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "news_vc") as! NewsViewController
                present(vc, animated: true)        }
    
    
    @IBAction func notesButton(_ sender: Any) {
        let vcc = storyboard?.instantiateViewController(withIdentifier: "notes_vc") as! NotesViewController
        present(vcc, animated: true)
    }
    
}

