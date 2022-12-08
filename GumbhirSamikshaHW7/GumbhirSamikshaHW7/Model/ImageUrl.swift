//
//  ImageUrl.swift
//  GumbhirSamikshaHW7
//
//  Created by Samiksha Gumbhir on 11/6/22.
//

import Foundation

struct ImageUrl : Decodable{
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}
