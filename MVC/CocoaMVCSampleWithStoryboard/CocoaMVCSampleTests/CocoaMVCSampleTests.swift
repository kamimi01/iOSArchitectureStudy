//
//  CocoaMVCSampleTests.swift
//  CocoaMVCSampleTests
//
//  Created by Mika Urakawa on 2021/05/25.
//  Copyright © 2021 史翔新. All rights reserved.
//

import XCTest
@testable import CocoaMVCSample

class CocoaMVCSampleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Model_カウントがマイナスされる() throws {
        XCTContext.runActivity(named: "カウントがマイナス1される") { _ in
            // Arrange
            let model = Model()
            
            // Act
            model.countDown()
            
            // Assert
            XCTAssertEqual(model.count, -1)
        }
        
        XCTContext.runActivity(named: "カウントがマイナス10される") { _ in
            // Arrange
            let model = Model()
            
            // Act
            for _ in 1..<11 {
                model.countDown()
            }
            
            // Assert
            XCTAssertEqual(model.count, -10)
        }
        
    }
    
    func test_Model_カウントがプラスされる() throws {
        XCTContext.runActivity(named: "カウントがプラス1される") { _ in
            // Arrange
            let model = Model()
            
            // Act
            model.countUp()
            
            // Assert
            XCTAssertEqual(model.count, 1)
        }
        XCTContext.runActivity(named: "カウントがプラス10される") { _ in
            // Arrange
            let model = Model()
            
            // Act
            for _ in 1..<11 {
                model.countUp()
            }
            
            // Assert
            XCTAssertEqual(model.count, 10)
        }
    }
    
    func test_Controller_マイナス関数が呼ばれる() throws{
        // Arrange
        // ViewControllerにあるModelをDIしたいができない
        // ViewControllerにControllerがあるからやりにくい気がする
        
        // Act
        let vc = ViewController()
        
        // Assert
        vc.onMinusTapped()
    }

    func test_Controller_プラス関数が呼ばれる() throws{
        // Arrange
        // ViewControllerにあるModelをDIしたいができない
        // ViewControllerにControllerがあるからやりにくい気がする
        
        // Act
        let vc = ViewController()
        
        // Assert
        vc.onPlusTapped()
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
