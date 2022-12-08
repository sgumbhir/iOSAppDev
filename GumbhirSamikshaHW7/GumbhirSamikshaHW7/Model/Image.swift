//
//  Image.swift
//  GumbhirSamikshaHW7
//
//  Created by Samiksha Gumbhir on 11/6/22.
//

import Foundation

struct Image : Decodable{
     let id: String
     let width: Int
     let height: Int
     let color: String
     let likes: Int
     let urls: ImageUrl
}

