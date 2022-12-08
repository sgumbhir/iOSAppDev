//
//  ViewController.swift
//  GumbhirSamikshaHW5
//
//  Created by Samiksha Gumbhir on 10/10/22.
//

import UIKit

class ViewController: UIViewController {
    
    private static let sharedInstance = FlashcardsModel()
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
   
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let currentFlashcard = ViewController.sharedInstance.randomFlashcard()
        questionLabel.text = currentFlashcard?.getQuestion()
        ViewController.sharedInstance.questionDisplayed = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTapRecognized))
       
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapRecognized))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeRecognized))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeRecognized))
        rightSwipe.direction = UISwipeGestureRecognizer.Direction.right
        doubleTap.numberOfTapsRequired = 2
        singleTap.require(toFail: doubleTap)
        mainView.addGestureRecognizer(singleTap)
        mainView.addGestureRecognizer(leftSwipe)
        mainView.addGestureRecognizer(rightSwipe)
        mainView.addGestureRecognizer(doubleTap)
        
    }
    
    @objc func singleTapRecognized(_ sender: UITapGestureRecognizer){
        let currentFlashcard = ViewController.sharedInstance.randomFlashcard()
        let firstAnimator = UIViewPropertyAnimator(duration: 1,
                                                   curve: .linear) {
            self.mainView.transform = CGAffineTransform(translationX: 0, y: 750)
        }
       firstAnimator.addCompletion { (position) in
           self.answerLabel.text = ""
           self.questionLabel.text = currentFlashcard?.getQuestion()
          let animator = UIViewPropertyAnimator(duration: 1,
                                                curve: UIView.AnimationCurve.linear) {
              self.mainView.transform = CGAffineTransform(translationX: 0, y: 0)
          }
          animator.startAnimation()
       }
       firstAnimator.startAnimation()
    }
    
    @objc func doubleTapRecognized(_ sender: UITapGestureRecognizer){
        let currentFlashcard = ViewController.sharedInstance.currentFlashcard()
        let firstAnimator = UIViewPropertyAnimator(duration: 1,
                                                   curve: .linear) {
            self.mainView.isHidden = true
        }
       firstAnimator.addCompletion { (position) in
           if (self.questionLabel.text == ""){
               self.questionLabel.text = currentFlashcard?.getQuestion()
               self.answerLabel.text = ""
           }
           else{
               self.questionLabel.text = ""
               self.answerLabel.text = currentFlashcard?.getAnswer()
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
        let currentFlashcard = ViewController.sharedInstance.nextFlashcard()
        let firstAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .linear) {
            self.mainView.transform = CGAffineTransform(translationX: -400, y: 0)
        }
       firstAnimator.addCompletion { (position) in
           self.questionLabel.text = currentFlashcard?.getQuestion()
           self.answerLabel.text = ""
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
        let currentFlashcard = ViewController.sharedInstance.previousFlashcard()
        let firstAnimator = UIViewPropertyAnimator(duration: 0.5,
                                                   curve: .linear) {
            self.mainView.transform = CGAffineTransform(translationX: 400, y: 0)
        }
       firstAnimator.addCompletion { (position) in
           self.questionLabel.text = currentFlashcard?.getQuestion()
           self.answerLabel.text = ""
           self.mainView.transform = CGAffineTransform(translationX: -400, y: 0)
           let animator = UIViewPropertyAnimator(duration: 0.5,
                                                curve: UIView.AnimationCurve.linear) {
              self.mainView.transform = CGAffineTransform(translationX: 0, y: 0)
          }
          animator.startAnimation()
       }
       firstAnimator.startAnimation()
    }


}

