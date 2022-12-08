////
////  GumbhirSamikshaHW5Tests.swift
////  GumbhirSamikshaHW5Tests
////
////  Created by Samiksha Gumbhir on 10/10/22.
////
//
//import XCTest
//@testable import GumbhirSamikshaHW6
//
//final class GumbhirSamikshaHW6Tests: XCTestCase {
//    
//    private var myModel: FlashcardsModel!
//
//    override func setUp(){
//        myModel = FlashcardsModel()
//    }
//
//    func testGetCount() {
//        let retCount = myModel.numberOfFlashcards()
//        XCTAssertEqual(retCount, 5)
//    }
//    
//    func testGetCurrent() {
//        let retCurrent = myModel.currentFlashcard()
//        let currentFlashcard = myModel.flashcard(at: 0)
//        XCTAssertEqual(retCurrent, currentFlashcard)
//    }
//    
//    func testGetPrevious() {
//        let retCurrent = myModel.previousFlashcard()
//        let currentFlashcard = myModel.flashcard(at: 4)
//        XCTAssertEqual(retCurrent, currentFlashcard)
//    }
//    
//    func testGetNext() {
//        let retCurrent = myModel.nextFlashcard()
//        let currentFlashcard = myModel.flashcard(at: 1)
//        XCTAssertEqual(retCurrent, currentFlashcard)
//    }
//    
//    func testGetRandom() {
//        let retCurrent = myModel.currentFlashcard()
//        let currentFlashcard = myModel.flashcard(at: myModel.getCurrentIndex())
//        XCTAssertEqual(retCurrent, currentFlashcard)
//    }
//    
//    func testGetFlashcard() {
//        let retCurrent = myModel.flashcard(at: 2)
//        let currentFlashcard = myModel.flashcard(at: 2)
//        XCTAssertEqual(retCurrent, currentFlashcard)
//    }
//    
//    func testInsertEnd() {
//        myModel.insert(question: "Question", answer: "Answer", favorite: false, at: myModel.numberOfFlashcards())
//        let retCurrent = myModel.flashcard(at: myModel.numberOfFlashcards()-1)
//        let testAgainst = Flashcard(question: "Question", answer: "Answer")
//        XCTAssertEqual(testAgainst, retCurrent)
//    }
//    
//    func testInsertAt() {
//        myModel.insert(question: "Question", answer: "Answer", favorite: false, at: 0)
//        let retCurrent = myModel.flashcard(at: 0)
//        let testAgainst = Flashcard(question: "Question", answer: "Answer")
//        XCTAssertEqual(testAgainst, retCurrent)
////        let value = myModel.getCurrentIndex()!
////        XCTAssertEqual(value, 1)
//    }
//    
//    func testRemove(){
//        myModel.removeFlashcard(at: 1)
//        XCTAssertEqual(myModel.numberOfFlashcards(), 4)
//    }
//    
//    func testToggleFavorite(){
//        myModel.toggleFavorite()
//        XCTAssertEqual(myModel.flashcard(at: myModel.getCurrentIndex())?.isFavorite, true)
//    }
//    
//    func testGetFavorites(){
//        myModel.toggleFavorite()
//        let _ = myModel.nextFlashcard()
//        myModel.toggleFavorite()
//        let favList = myModel.favoriteFlashcards()
//        var checkAgainst = [Flashcard]()
//        checkAgainst.append(myModel.flashcard(at: 0)!)
//        checkAgainst.append(myModel.flashcard(at: 1)!)
//        XCTAssertEqual(favList, checkAgainst)
//    }
//    
//    func testSingleton(){
//        let model1 = FlashcardsModel.sharedInstance
//        let model2 = FlashcardsModel.sharedInstance
//        model1.insert(question: "Question", answer: "answer", favorite: false, at: myModel.numberOfFlashcards())
//        XCTAssertEqual(model1.numberOfFlashcards(), model2.numberOfFlashcards())
//    }
//
//}
