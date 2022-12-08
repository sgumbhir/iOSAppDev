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
    public var questionDisplayed: Bool = false
    public static let sharedInstance: FlashcardsModel = FlashcardsModel()
    let kFlashcardsArrayKey = "FlashcardsArray"
    var flashcardsFilePath: URL!
    
    func save() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(flashcards)
            let dataString = String(data: data, encoding: .utf8)!
            try dataString.write(toFile: flashcardsFilePath.path,
                               atomically: true, encoding: .utf8)
        } catch {
            print("Could not save to file")
        }
    }
    
    
    
    override init(){
        super.init()
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        flashcardsFilePath = documentsUrl.appendingPathComponent("FlashcardsModel.plist")
        
        if let loadedFlashcards = load() {
            self.flashcards = loadedFlashcards
        
        } else {
            let flashcard1 = Flashcard(question: "What is the tip of a shoelace called?", answer: "Aglet")
            let flashcard2 = Flashcard(question: "What is the only mammal that can fly?", answer: "Bat")
            let flashcard3 = Flashcard(question: "How many hearts does an octopus have?", answer: "3")
            let flashcard4 = Flashcard(question: "What color is a polar bear's skin?", answer: "Black", isFavorite: true)
            let flashcard5 = Flashcard(question: "How many muscles does a human finger have?", answer: "0")
            flashcards.append(flashcard1)
            flashcards.append(flashcard2)
            flashcards.append(flashcard3)
            flashcards.append(flashcard4)
            flashcards.append(flashcard5)
            save()
        }
        
        questionDisplayed = true
        if numberOfFlashcards() <= 0 {
            currentIndex = nil
        }
        else{
            currentIndex = 0
        }
        
    }
    
    func getCurrentIndex() -> Int {
        return currentIndex ?? 0
    }
    
    func numberOfFlashcards() -> Int {
        return flashcards.count
    }
    
    func randomFlashcard() -> Flashcard? {
        if numberOfFlashcards() == 0 {
            return nil
        }
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
        save()
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
            if numberOfFlashcards() <= 1 {
                currentIndex = nil
            }
            else{
                currentIndex = index - 1
            }
        }
        else if currentIndex != nil && currentIndex! - 1 == index  {
            currentIndex = currentIndex! - 1
        }
        if numberOfFlashcards() <= 1 {
            currentIndex = nil
        }
        flashcards.remove(at: index)
        save()
    }
    
    func toggleFavorite() {
        if let index = currentIndex {
            flashcards[index].isFavorite = !flashcards[index].isFavorite
        }
        save()
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
    
    func rearrageFlashcards(from: Int, to: Int) {
        if from < 0 || from > numberOfFlashcards()-1 {
            return
        }
        if to < 0 || to > numberOfFlashcards()-1 {
            return
        }
        let current = flashcards[from]
        flashcards.remove(at: from)
        flashcards.insert(current, at: to)
        save()
    }
    
    func checkAskedQuestion(potentialQuestion: String) -> Bool {
        for element in flashcards{
            if element.getQuestion().lowercased().contains(potentialQuestion.lowercased()){
                return true
            }
        }
        return false
    }
    
    private func load() -> [Flashcard]?{
        let decoder = JSONDecoder()
                
        do {
            let data = try Data(contentsOf: flashcardsFilePath)
            let flashcards = try decoder.decode(Array<Flashcard>.self, from: data)
            return flashcards
        } catch {
            print("error \(error)")
            return nil
        }
    }
    
    
}
