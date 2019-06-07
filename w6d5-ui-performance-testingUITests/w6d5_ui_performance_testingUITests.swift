//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Dayson Dong on 2019-06-07.
//  Copyright © 2019 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        app = XCUIApplication()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {

        testDeleteMeal()
    }
    
    func addNewMeal(named name: String, cal: Int) {
        
        app.navigationBars["Master"].buttons["Add"].tap()
        
        let addAMealAlert = app.alerts["Add a Meal"]
        let collectionViewsQuery = addAMealAlert.collectionViews
        collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element.typeText(name)
        let textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
        textField.tap()
        textField.typeText("\(cal)")
        
        addAMealAlert.buttons["Ok"].tap()
        
        
    }
    
    func deleteMeal(named name: String, cal: Int) {
        
        let tablesQuery = app.tables
        let staticText = tablesQuery.staticTexts["\(name) - \(cal)"]
        if staticText.exists {
            staticText.swipeLeft()
            tablesQuery.buttons["Delete"].tap()
        }
    }
    
    func addAndDeleteMeal(named name: String, cal: Int) {
        addNewMeal(named: name, cal: cal)
        deleteMeal(named: name, cal: cal)
        
    }
    


    func testAddMeal() {

        addNewMeal(named: "burger", cal: 300)
        
    }
    
    func testDeleteMeal() {
        
        deleteMeal(named: "burger", cal: 300)
        
    }
    
    func testShowDetail() {
        
        let app = XCUIApplication()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["burger - 300"]/*[[".cells.staticTexts[\"burger - 300\"]",".staticTexts[\"burger - 300\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCTAssertEqual("burger - 300",app/*@START_MENU_TOKEN@*/.staticTexts["detailViewControllerLabel"]/*[[".staticTexts[\"burger - 300\"]",".staticTexts[\"detailViewControllerLabel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.label)
        app.navigationBars["Detail"].buttons["Master"].tap()
        
    }
    
    func testDeleteAllMeals() {
        
        let app = XCUIApplication()
        let element = app.statusBars.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        element.tap()
        
        let tablesQuery = app.tables.cells
        while tablesQuery.count > 0 {
            tablesQuery.element(boundBy: 0).swipeLeft()
            tablesQuery.element(boundBy: 0).buttons["Delete"].tap()
        }
    }
    
    func testAddAndDeleteMeal() {
        
        let name = "name"
        let cal = 100
        
        measure {
            addAndDeleteMeal(named: name, cal: cal)
        }
        
        
        
    }

}
