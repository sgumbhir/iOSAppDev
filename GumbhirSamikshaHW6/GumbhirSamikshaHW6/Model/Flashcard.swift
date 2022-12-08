//
//  Flashcard.swift
//  GumbhirSamikshaHW5
//
//  Created by Samiksha Gumbhir on 10/10/22.
//

import Foundation

struct Flashcard:Equatable, Codable{
    private var question: String
    private var answer: String
    public var isFavorite: Bool
    
    func getQuestion() -> String {
        return question
    }
    
    func getAnswer() -> String {
        return answer
    }
    
    init(question: String, answer: String, isFavorite: Bool=false){
        self.question = question
        self.answer = answer
        self.isFavorite = isFavorite
    }
}
