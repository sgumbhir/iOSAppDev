//
//  YelpModel.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/2/22.
//

import Foundation

class YelpModel: NSObject {
    
    public static let sharedInstance: YelpModel = YelpModel()
    private var restaurants = Array<RestaurantModel>();
    private var favoritedRestaurants = Array<String>();
    private var restaurantList: RestaurantList?
    private var base_url = "https://api.yelp.com/v3/businesses/search?"
    private var default_url: String
    private var location_url: String?
    private var auth_string = "Bearer 0AZQeWuwPwA90lA48ahhrDhKmpQg7idhzgqHzWwOh-lb11TDH6MrXtX0ySG0LNS-L2O7z0AZ0Kd_x-dFLuP23T6cNIZ_NwUF7AEgjz5SBug04W8HsL5ZbUSj3MysX3Yx"
    
    override init(){
        self.default_url = self.base_url + "location=LA&categories=coffee"
        super.init()

    }
    
    // Function to set location according to the user's current location
    func setLocation(_ _lat: Double, _ _long: Double){
        location_url = base_url + "latitude=\(_lat)&longitude=\(_long)&categories=coffee"
    }
    
    // Function to get restaurant data from yelp
    func getRestaurants(onSuccess: @escaping ([RestaurantModel]) -> Void){
        
        var url: URL?
        
        /* Setting url to pull data from based on whether or
           not user shared live location */
        if let string_url = location_url {
            url = URL(string: string_url)
        }
        else{
            url = URL(string: default_url)
        }
        
        var urlRequest = URLRequest(url: url!);
        urlRequest.addValue(auth_string, forHTTPHeaderField: "Authorization")
        
        // Create request and on success pass the returned restaurant array
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            do{
                let decoder = JSONDecoder()
                self.restaurantList = try decoder.decode(RestaurantList.self, from: data!)
                self.restaurants = self.restaurantList!.businesses
                onSuccess(self.restaurants)
            }
            catch{
                print(error)
                exit(1)
            }
        }
        
        task.resume()

    }
    
    // Function that returns a list of all restaurants
    func returnRestaurants() -> [RestaurantModel]{
        return self.restaurants
    }
    
    // Function to add restaurant to favorite list
    func addToFavorites(_ name: String) {
        // If not already in favorites
        if(!isFavorite(name)){
            favoritedRestaurants.insert(name, at: 0)
        }
    }
    
    // Function to remove restaurant to favorite list
    func removeFavorite(_ idx: Int) {
        favoritedRestaurants.remove(at: idx)
    }
    
    // Function to check if a restaurant is favorited
    func isFavorite(_ name: String) -> Bool {
        return favoritedRestaurants.contains(name)
    }
    
    // Function to return a list of favorites restaurants 
    func favoritesList() -> [String] {
        return favoritedRestaurants
    }
}
