//
//  MapViewController.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/2/22.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    private var distanceFromStart: Double?
    private var startPoint: CLLocation?
    private var selectedStore: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up location manager
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
       
        locationManager.startUpdatingLocation()
        
        //Setting up the map view
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
    }
    
//    func locationManager(_ manager: CLLocationManager,
//                            didChangeAuthorization status: CLAuthorizationStatus) {
//        switch status {
//        case .notDetermined:
//            break
//            
//        case .restricted, .denied:
//            showWithDefault()
//    }
    
    func showWithDefault() {
        // Get restaurants from yelp depending on default location
        YelpModel.sharedInstance.getRestaurants{ restaurants in
            DispatchQueue.main.async {
                for restaurant in restaurants {
                    let coordinate = CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude)
                    let newMarker = Marker(coordinate: coordinate, title: restaurant.name, subtitle: "\(restaurant.rating)")
                    var pinAnnotationView = MKPinAnnotationView(annotation: newMarker, reuseIdentifier: "custom")
                    // Is a Favorited restaurant
                    if(YelpModel.sharedInstance.isFavorite(restaurant.name)) {
                        pinAnnotationView = MKPinAnnotationView(annotation: newMarker, reuseIdentifier: "favorite")
                    }
                    
                    self.mapView.addAnnotation(pinAnnotationView.annotation!)
                }
            }
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Get a marker for the start location of user
        if let location = locations.first{
            if let startPoint = startPoint{
                self.distanceFromStart = location.distance(from: startPoint)
            }
            else{
                self.startPoint = location
                self.distanceFromStart = 0
                let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
                self.mapView.setRegion(region, animated: true)
            }
            
            // If successfully recieved location - set url based on lat long
            YelpModel.sharedInstance.setLocation(location.coordinate.latitude, location.coordinate.longitude)
            locationManager.stopUpdatingLocation()
        }
        
        // Get restaurants from yelp depending on lat, long, or default location
        YelpModel.sharedInstance.getRestaurants{ restaurants in
            DispatchQueue.main.async {
                for restaurant in restaurants {
                    let coordinate = CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude)
                    let newMarker = Marker(coordinate: coordinate, title: restaurant.name, subtitle: "\(restaurant.rating)")
                    var pinAnnotationView = MKPinAnnotationView(annotation: newMarker, reuseIdentifier: "custom")
                    // Is a Favorited restaurant
                    if(YelpModel.sharedInstance.isFavorite(restaurant.name)) {
                        pinAnnotationView = MKPinAnnotationView(annotation: newMarker, reuseIdentifier: "favorite")
                    }
                    
                    self.mapView.addAnnotation(pinAnnotationView.annotation!)
                }
            }
        }
        
    }
    
    //  View favorites list
    @IBAction func favoritesPressed(_ sender: UIBarButtonItem) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "TableViewControllerID") as! FavoritesTableViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    // If a pin is selected on the map
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView){
        
        self.mapView.removeOverlays(self.mapView.overlays(in: MKOverlayLevel.aboveRoads))
        let alertController = UIAlertController(title: "What would you like to do", message: "", preferredStyle: .actionSheet)
        let directionsAction = UIAlertAction(title: "Get Directions", style: .default, handler: getDirections)
        let pageAction = UIAlertAction(title: "Store page", style: .default, handler: showStorePage)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(directionsAction)
        alertController.addAction(pageAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        self.selectedStore = view.annotation?.title!
    }
    
    // Get Directions to a pin
    func getDirections(_ sender: UIAlertAction) -> Void {
        var dest = CLLocationCoordinate2D(latitude: 100, longitude: 100)
        let restaurants = YelpModel.sharedInstance.returnRestaurants()
        for restaurant in restaurants {
            if restaurant.name == self.selectedStore! {
                dest = CLLocationCoordinate2D(latitude: restaurant.coordinates.latitude, longitude: restaurant.coordinates.longitude)
            }
        }
        
        /* Code adapted from https://medium.com/fabcoding/swift-display-route-between-2-locations-using-mapkit-7de8ee0acd38
         to get directions */
        let request = MKDirections.Request()
        let src = CLLocationCoordinate2D(latitude: (startPoint?.coordinate.latitude)!, longitude: (startPoint?.coordinate.longitude)!)
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: src, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: dest, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile

        let directions = MKDirections(request: request)

        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            //for getting just one route
            if let route = unwrappedResponse.routes.first {
                //show on map
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.aboveRoads)
                //set the map area to show the route
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets.init(top: 80.0, left: 20.0, bottom: 100.0, right: 20.0), animated: true)
            }
        }
    }
    
    // Logic to see the directions
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
       let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
       renderer.strokeColor = UIColor.blue
       return renderer
   }
    
    // When want to see a store page
    func showStorePage(_ sender: UIAlertAction) -> Void{
        self.performSegue(withIdentifier: "showStore", sender: self)
    }
    
    // Segue to show store page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showStore" {
            let destination = segue.destination as! StoreViewController
            destination.storeName = self.selectedStore
            
        }
    }
    
    // Logout and go back to initial page
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
    }
    

}
