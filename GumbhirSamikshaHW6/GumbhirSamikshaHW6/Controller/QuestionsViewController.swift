//
//  ViewController.swift
//  GumbhirSamikshaHW5
//
//  Created by Samiksha Gumbhir on 10/10/22.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    
    @IBOutlet weak var favoritedStar: UIButton!
    @IBOutlet weak var emptyStar: UIButton!
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let currentFlashcard = FlashcardsModel.sharedInstance.randomFlashcard()
        self.displayQuestion(currentFlashcard)
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapRecognized))
       
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapRecognized))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeRecognized))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeRecognized))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        doubleTap.numberOfTapsRequired = 2
        let doubleTapEmpty = UITapGestureRecognizer(target: self, action: #selector(doubleTapRecognizedEmpty))
        let doubleTapFilled = UITapGestureRecognizer(target: self, action: #selector(doubleTapRecognizedFilled))
        doubleTapEmpty.numberOfTapsRequired = 2
        doubleTapFilled.numberOfTapsRequired = 2
        singleTap.require(toFail: doubleTap)
        singleTap.require(toFail: doubleTapEmpty)
        singleTap.require(toFail: doubleTapFilled)
        doubleTap.require(toFail: doubleTapEmpty)
        doubleTap.require(toFail: doubleTapFilled)
        
        mainView.addGestureRecognizer(singleTap)
        mainView.addGestureRecognizer(leftSwipe)
        mainView.addGestureRecognizer(rightSwipe)
        mainView.addGestureRecognizer(doubleTap)
        
        emptyStar.addGestureRecognizer(doubleTapEmpty)
        favoritedStar.addGestureRecognizer(doubleTapFilled)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let currentFlashcard = FlashcardsModel.sharedInstance.currentFlashcard()
        self.displayQuestion(currentFlashcard)
        
    }
    
    @objc func singleTapRecognized(_ sender: UITapGestureRecognizer){
        let currentFlashcard = FlashcardsModel.sharedInstance.randomFlashcard()
        let firstAnimator = UIViewPropertyAnimator(duration: 1,
                                                   curve: .linear) {
            self.mainView.transform = CGAffineTransform(translationX: 0, y: 750)
        }
       firstAnimator.addCompletion { (position) in
           self.displayQuestion(currentFlashcard)
          let animator = UIViewPropertyAnimator(duration: 1,
                                                curve: UIView.AnimationCurve.linear) {
              self.mainView.transform = CGAffineTransform(translationX: 0, y: 0)
          }
          animator.startAnimation()
       }
       firstAnimator.startAnimation()
    }
    
    @objc func doubleTapRecognizedEmpty(_ sender: UITapGestureRecognizer){
        print("here")
        emptyStar.isHidden = true
        favoritedStar.isHidden = false
        FlashcardsModel.sharedInstance.toggleFavorite()
    }
    
    @objc func doubleTapRecognizedFilled(_ sender: UITapGestureRecognizer){
        print("here2")
       
    }
    
    @objc func doubleTapRecognized(_ sender: UITapGestureRecognizer){
        let currentFlashcard = FlashcardsModel.sharedInstance.currentFlashcard()
        let firstAnimator = UIViewPropertyAnimator(duration: 1,
                                                   curve: .linear) {
            self.mainView.isHidden = true
        }
       firstAnimator.addCompletion { (position) in
           if (self.questionLabel.text == ""){
               self.displayQuestion(currentFlashcard)
           }
           else{
               self.questionLabel.text = ""
               if currentFlashcard == nil {
                   self.answerLabel.text = "Please add more flashcards"
               }
               else{
                   self.answerLabel.text = currentFlashcard?.getAnswer()
                   if currentFlashcard?.isFavorite == true{
                       self.emptyStar.isHidden = true
                       self.favoritedStar.isHidden = false
                   }
                   else{
                       self.emptyStar.isHidden = false
                       self.favoritedStar.isHidden = true
                   }
               }
           }
           
          let animator = UIViewPropertyAnimator(duration: 1,
                                                curve: UIView.AnimationCurve.linear) {
              self.mainView.isHidden = false
          }
          animator.startAnimation()
       }
       firstAnimator.startAnimation()
    }
    
    @objc func leftSwipeRecognized(_ sender: UITapGestureRecognizer){
        let currentFlashcard = FlashcardsModel.sharedInstance.nextFlashcard()
        let firstAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .linear) {
            self.mainView.transform = CGAffineTransform(translationX: -400, y: 0)
        }
       firstAnimator.addCompletion { (position) in
           self.displayQuestion(currentFlashcard)
           self.mainView.transform = CGAffineTransform(translationX: 400, y: 0)
           let animator = UIViewPropertyAnimator(duration: 0.5,
                                                curve: UIView.AnimationCurve.linear) {
              self.mainView.transform = CGAffineTransform(translationX: 0, y: 0)
          }
          animator.startAnimation()
       }
       firstAnimator.startAnimation()
    }
    
    @objc func rightSwipeRecognized(_ sender: UITapGestureRecognizer){
        let currentFlashcard = FlashcardsModel.sharedInstance.previousFlashcard()
        let firstAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .linear) {
            self.mainView.transform = CGAffineTransform(translationX: 400, y: 0)
        }
       firstAnimator.addCompletion { (position) in
           self.displayQuestion(currentFlashcard)
           self.mainView.transform = CGAffineTransform(translationX: -400, y: 0)
           let animator = UIViewPropertyAnimator(duration: 0.5,
                                                curve: UIView.AnimationCurve.linear) {
              self.mainView.transform = CGAffineTransform(translationX: 0, y: 0)
          }
          animator.startAnimation()
       }
       firstAnimator.startAnimation()
    }
    
    
    func displayQuestion(_ currentFlashcard: Flashcard?){
        self.answerLabel.text = ""
        if currentFlashcard == nil {
            self.questionLabel.text = "No flashcards available"
        }
        else{
            self.questionLabel.text = currentFlashcard?.getQuestion()
            if currentFlashcard?.isFavorite == true{
                self.emptyStar.isHidden = true
                self.favoritedStar.isHidden = false
            }
            else{
                self.emptyStar.isHidden = false
                self.favoritedStar.isHidden = true
            }
        }
    }

    @IBAction func emptyStartPressed(_ sender: UIButton) {
        emptyStar.isHidden = true
        favoritedStar.isHidden = false
        FlashcardsModel.sharedInstance.toggleFavorite()
        
    }
    
    @IBAction func filledStarPressed(_ sender: UIButton) {
        emptyStar.isHidden = false
        favoritedStar.isHidden = true
        FlashcardsModel.sharedInstance.toggleFavorite()
    }
}

