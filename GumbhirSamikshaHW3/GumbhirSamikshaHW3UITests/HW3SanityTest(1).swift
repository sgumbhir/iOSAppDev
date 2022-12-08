//
//  HW3SanityTest.swift
//  HW3
//
//  Created by Harrison Weinerman on 8/24/18.
//  Copyright © 2018 Harrison Weinerman. All rights reserved.
//

import XCTest

class HW3SanityTest: XCTestCase {
    
    private let app = XCUIApplication()

    override func setUp() {
        super.setUp()
        continueAfterFailure = true
        XCUIApplication().launch()
    }
    
    /// This test should pass regardless of how you configured your app
    func testBasicUIElements() {
        let questionLabel = app.staticTexts[HW3AccessibilityIdentifiers.questionLabel]
        let messageLabel = app.staticTexts[HW3AccessibilityIdentifiers.messageLabel]
        let answerTextField = app.textFields[HW3AccessibilityIdentifiers.answerTextField]
        let optionButton1 = app.buttons[HW3AccessibilityIdentifiers.optionButton1]
        let optionButton2 = app.buttons[HW3AccessibilityIdentifiers.optionButton2]
        let resetButton = app.buttons[HW3AccessibilityIdentifiers.resetButton]
        
        [questionLabel,
         answerTextField,
         optionButton1,
         optionButton2,
         messageLabel,
         resetButton].forEach({ XCTAssert($0.exists) })
    }
    
    /// This test should only pass if you implemented UIButtons and UIImageViews for option selection
    func testImageViews() {
        let answerImageView1 = app.images[HW3AccessibilityIdentifiers.answerImageView1]
        let answerImageView2 = app.images[HW3AccessibilityIdentifiers.answerImageView2]
        
        [answerImageView1,
         answerImageView2].forEach({
            XCTAssert($0.exists)
         })
    }
}
