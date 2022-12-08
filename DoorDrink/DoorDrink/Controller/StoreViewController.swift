//
//  StoreViewController.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/5/22.
//

import UIKit
import WebKit

class StoreViewController: UIViewController {

    
    public var storeName: String?
    
    
    @IBOutlet weak var storeImage: WKWebView!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setValues()
        
        
    }
    
    // Update store information using yelp results
    func setValues(){
        if let name = storeName {
            navBar.title = name
            let restaurants = YelpModel.sharedInstance.returnRestaurants()
            for restaurant in restaurants {
                if name == restaurant.name {
                    let url = URL(string: restaurant.image_url)
                    let request = URLRequest(url: url!)
                    storeImage.load(request)
                    ratingsLabel.text = "\(restaurant.rating)"
                    reviewCountLabel.text = "\(restaurant.review_count)"
                }
            }
        }
    }
    
    // Go back to map page
    @IBAction func backDidPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Open set reminder page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "setReminder" {
            let destination = segue.destination as! SetReminderViewController
            destination.storeName = self.storeName
            
        }
    }
    
    // Make restaurant part of the favorites list
    @IBAction func favoritePressed(_ sender: UIBarButtonItem) {
        if let name = storeName {
            YelpModel.sharedInstance.addToFavorites(name)
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
