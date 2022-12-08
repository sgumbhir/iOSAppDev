//
//  FavoriteViewController.swift
//  GumbhirSamikshaHW6
//
//  Created by Samiksha Gumbhir on 10/22/22.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                              "TableCell", for: indexPath)
           // Configure the cell...
       let favList = FlashcardsModel.sharedInstance.favoriteFlashcards()
       let flashcard = favList[indexPath.row]
       cell.textLabel?.text = flashcard.getQuestion()
       cell.detailTextLabel?.text = flashcard.getAnswer()

       return cell
    }
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let favorites = FlashcardsModel.sharedInstance.favoriteFlashcards()
        print(favorites.count)
        return favorites.count
    }


}
