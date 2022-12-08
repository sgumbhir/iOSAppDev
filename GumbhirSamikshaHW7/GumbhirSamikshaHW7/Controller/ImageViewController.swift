//
//  ImageViewController.swift
//  GumbhirSamikshaHW7
//
//  Created by Samiksha Gumbhir on 11/6/22.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class ImageViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    public var sorted_images: [Image]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        loadImages()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loadImage"{
            let destination = segue.destination as! ImageDetailViewController
            let indexPath = collectionView.indexPathsForSelectedItems!.first!.row
            if let curr_array = sorted_images{
                destination.selectedItem = curr_array[indexPath]
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
    
        return ImageModel.sharedInstance.images.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        if let curr_array = sorted_images{
            let url = URL(string: curr_array[indexPath.row].urls.full)
        
            // Configure the cell
            cell.imageViewCell.kf.setImage(with: url)
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func loadImages(){
        ImageModel.sharedInstance.getImages{ images in
            DispatchQueue.main.async {
                //sort based on likes
                self.sorted_images = images.sorted(by: { $0.likes > $1.likes})
                //call reload
                self.collectionView.reloadData()
            }
            
        }
    }

//    //Functionality for refresh button being tapped
    @IBAction func refreshDidTapped(_ sender: UIBarButtonItem) {
        loadImages()
    }
    
}
