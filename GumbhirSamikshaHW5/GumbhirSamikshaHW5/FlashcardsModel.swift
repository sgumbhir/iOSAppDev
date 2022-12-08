//
//  FlashcardsModel.swift
//  GumbhirSamikshaHW5
//
//  Created by Samiksha Gumbhir on 10/10/22.
//

import Foundation

class FlashcardsModel: NSObject, FlashcardsDataModel{
    
    private var flashcards = Array<Flashcard>()
    private var currentIndex: Int?
    public var questionDisplayed: Bool
    public static let sharedInstance: FlashcardsModel = FlashcardsModel()
    
    override init(){
        let flashcard1 = Flashcard(question: "What is the tip of a shoelace called?", answer: "Aglet")
        let flashcard2 = Flashcard(question: "What is the only mammal that can fly?", answer: "Bat")
        let flashcard3 = Flashcard(question: "How many hearts does an octopus have?", answer: "3")
        let flashcard4 = Flashcard(question: "What color is a polar bear's skin?", answer: "Black")
        let flashcard5 = Flashcard(question: "How many muscles does a human finger have?", answer: "0")
        flashcards.append(flashcard1)
        flashcards.append(flashcard2)
        flashcards.append(flashcard3)
        flashcards.append(flashcard4)
        flashcards.append(flashcard5)
        questionDisplayed = true
        currentIndex = 0
    }
    
    func getCurrentIndex() -> Int {
        return currentIndex ?? 0
    }
    
    func numberOfFlashcards() -> Int {
        return flashcards.count
    }
    
    func randomFlashcard() -> Flashcard? {
        var idx = Int.random(in: 0..<numberOfFlashcards())
        while (currentIndex == idx) && (numberOfFlashcards() > 1){
            idx = Int.random(in: 0..<numberOfFlashcards())
        }
        currentIndex = idx
        return flashcards[idx]
    }
    
    func flashcard(at index: Int) -> Flashcard? {
        if(index < 0 || index >= numberOfFlashcards()){
            return nil
        }
        currentIndex = index
        return flashcards[index]
    }
    
    func nextFlashcard() -> Flashcard? {
        if let index = currentIndex {
            var _index = index + 1;
            if(_index >= numberOfFlashcards()){
                _index = 0
            }
            currentIndex = _index
            return flashcards[_index]
        }
        else{
            return nil
        }
    }
    
    func previousFlashcard() -> Flashcard? {
        if let index = currentIndex {
            var _index = index - 1;
            if(_index < 0){
                _index = numberOfFlashcards()-1
            }
            currentIndex = _index
            return flashcards[_index]
        }
        else{
            return nil
        }
    }
    
    func insert(question: String, answer: String, favorite: Bool) {
        let flashcard1 = Flashcard(question: question, answer: answer, isFavorite: favorite)
        flashcards.append(flashcard1)
        if currentIndex == nil{
            currentIndex = 0
        }
    }
    
    func insert(question: String, answer: String, favorite: Bool, at index: Int) {
        if(index < 0 || index > numberOfFlashcards()){
            return
        }
        if (currentIndex == index || currentIndex == index - 1), let tempIndex = currentIndex{
            self.currentIndex = tempIndex + 1
        }
        if currentIndex == nil{
            currentIndex = 0
        }
        let flashcard1 = Flashcard(question: question, answer: answer, isFavorite: favorite)
        flashcards.insert(flashcard1, at: index)
    }
    
    func currentFlashcard() -> Flashcard? {
        if let index = currentIndex {
            return flashcards[index]
        }
        else{
            return nil
        }
    }
    
    func removeFlashcard(at index: Int) {
        if(index < 0 || index >= numberOfFlashcards()){
            return
        }
        if currentIndex == index {
            if numberOfFlashcards() != 0 {
                currentIndex = 0
            }
            else{
                currentIndex = nil
            }
        }
        if currentIndex != nil && currentIndex == index - 1 {
            currentIndex = currentIndex! - 1
        }
        flashcards.remove(at: index)
    }
    
    func toggleFavorite() {
        if let index = currentIndex {
            flashcards[index].isFavorite = !flashcards[index].isFavorite
        }
    }
    
    func favoriteFlashcards() -> [Flashcard] {
        var favFlashcards = [Flashcard]()
        for flashcard in flashcards {
            if flashcard.isFavorite {
                favFlashcards.append(flashcard)
            }
        }
        return favFlashcards
    }
    
}
