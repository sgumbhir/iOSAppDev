//
//  TableViewController.swift
//  GumbhirSamikshaHW6
//
//  Created by Samiksha Gumbhir on 10/21/22.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButton.isEnabled = true
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
            sender.title = "Edit"
        } else {
            tableView.isEditing = true
            sender.title = "Done"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let addQuestion = segue.destination as! AddViewController
        addQuestion.completionHandler = {(question: String?, answer: String?, isFav: Bool) in
            if let question = question, let answer = answer{
                FlashcardsModel.sharedInstance.insert(question: question, answer: answer, favorite: isFav, at: FlashcardsModel.sharedInstance.numberOfFlashcards())
                self.tableView.reloadData()
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FlashcardsModel.sharedInstance.numberOfFlashcards()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                       "TableCell", for: indexPath)
            // Configure the cell...
        if let flashcard = FlashcardsModel.sharedInstance.flashcard(at: indexPath.row){
            cell.textLabel?.text = flashcard.getQuestion()
            cell.detailTextLabel?.text = flashcard.getAnswer()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            FlashcardsModel.sharedInstance.removeFlashcard(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }

    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        FlashcardsModel.sharedInstance.rearrageFlashcards(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
