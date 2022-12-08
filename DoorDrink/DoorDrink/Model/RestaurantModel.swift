//
//  RestaurantModel.swift
//  DoorDrink
//
//  Created by Samiksha Gumbhir on 12/2/22.
//

import Foundation

struct RestaurantList: Decodable {
    let businesses: [RestaurantModel]
}

// Struct to store restaurant information
struct RestaurantModel: Decodable {
    let name: String
    let image_url: String
    let url: String
    let review_count: Int
    let rating: Double
    let coordinates: Coordinates
}

struct Coordinates: Decodable {
    let latitude: Double
    let longitude: Double
}
