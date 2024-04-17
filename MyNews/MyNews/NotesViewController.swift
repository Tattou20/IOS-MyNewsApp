//
//  NotesViewController.swift
//  MyNews
//
//  Created by user238581 on 4/17/24.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes = [Note]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        notes = [
            Note(title: "Time Management", content: "In today's fast-paced world, mastering time management is paramount for individuals aiming to achieve their goals and maintain a healthy work-life balance. This note delves into various strategies and techniques to help individuals optimize their time effectively. From prioritizing tasks and setting achievable goals to implementing time-blocking methods and minimizing distractions, each strategy is designed to enhance productivity and focus. By adopting these practices, individuals can take control of their time, reduce stress, and accomplish more in both their professional and personal lives."),
            Note(title: "Digital Transformation", content: "The digital transformation revolutionizes the way businesses operate, driving innovation, efficiency, and competitiveness across industries. This note provides an overview of the key drivers and implications of digital transformation, from the adoption of cloud computing and data analytics to the integration of artificial intelligence and automation. It explores how businesses are leveraging digital technologies to enhance customer experiences, optimize processes, and gain a competitive edge in the market. By embracing digital transformation, organizations can adapt to the evolving business landscape, unlock new opportunities, and drive sustainable growth."),
            Note(title: "Communication Skills", content: "Effective communication skills are essential for building strong relationships, fostering teamwork, and achieving success in the workplace. This note explores various communication strategies and techniques to help individuals enhance their communication abilities. From active listening and empathy to clarity and assertiveness, each skill plays a crucial role in facilitating clear and meaningful communication. Additionally, the note discusses the importance of nonverbal communication cues, such as body language and tone of voice, in conveying messages effectively. By honing these communication skills, individuals can improve their professional relationships, resolve conflicts, and drive positive outcomes in their work environments."),
            Note(title: "Financial Planning", content: "Financial planning is a vital aspect of achieving long-term financial security and prosperity. This note provides practical insights and strategies to help individuals manage their finances effectively. It covers a wide range of topics, including budgeting, saving, investing, retirement planning, and risk management. By creating a comprehensive financial plan tailored to their goals and circumstances, individuals can make informed decisions, build wealth over time, and achieve financial independence. Whether saving for retirement, buying a home, or starting a business, sound financial planning lays the foundation for a secure and fulfilling future."),
        ]    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = note.content
        
        // Add delete button
            let deleteButton = UIButton(type: .system)
            deleteButton.setTitle("Delete", for: .normal)
            deleteButton.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
            cell.accessoryView = deleteButton
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNote = notes[indexPath.row]
        performSegue(withIdentifier: "showNoteDetail", sender: selectedNote)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNoteDetail" {
            if let noteDetailVC = segue.destination as? NoteDetailViewController,
               let selectedNote = sender as? Note {
                noteDetailVC.note = selectedNote
            }
        }
    }
    @IBAction func addNoteButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "New Note", message: "Enter the title and content for your new note", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Title"
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Content"
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let titleTextField = alertController.textFields?.first,
                  let contentTextField = alertController.textFields?.last,
                  let title = titleTextField.text,
                  let content = contentTextField.text,
                  !title.isEmpty else {
                return
            }
            
            // Create a new note with the provided title and content
            let newNote = Note(title: title, content: content)
            
            // Add the new note to the array
            self?.notes.append(newNote)
            
            // Reload the table view to reflect the changes
            self?.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    func deleteNote(at indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNote(at: indexPath)
        }
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        deleteNote(at: indexPath)
    }
}






















