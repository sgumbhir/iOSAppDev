//
//  FavoritesTableViewController.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/7/22.
//

import UIKit

class FavoritesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return YelpModel.sharedInstance.favoritesList().count
    }

    // Configuring the cells using the favorites list stored in Yelp
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
                       "TableCell", for: indexPath)
            // Configure the cell...
        let restaurant = YelpModel.sharedInstance.favoritesList()[ indexPath.row]
        cell.textLabel?.text = restaurant
        
        return cell
    }

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            YelpModel.sharedInstance.removeFavorite(indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // Go back to the map
    @IBAction func mapButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // If edit is pressed start editing the favorites
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.isEditing = false
            sender.title = "Edit"
        } else {
            tableView.isEditing = true
            sender.title = "Done"
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
