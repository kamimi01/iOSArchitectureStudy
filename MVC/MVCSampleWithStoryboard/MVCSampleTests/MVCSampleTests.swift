//
//  MVCSampleTests.swift
//  MVCSampleTests
//
//  Created by Mika Urakawa on 2021/05/16.
//

import XCTest
@testable import MVCSample

class MVCSampleTests: XCTestCase {

    override func setUpWithError() throws {
        // 何もしない
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_Model_カウントがマイナス1される() throws {
        // Arrange
        let model = Model()
        
        // Act
        model.countDown()
        
        // Assert
        XCTAssertEqual(model.count, -1)
    }
    
    func test_Model_カウントがマイナス10される() throws {
        // Arrange
        let model = Model()
        
        // Act
        for _ in 1..<11 {
            model.countDown()
        }
        
        // Assert
        XCTAssertEqual(model.count, -10)
    }
    
    func test_Model_カウントがプラス1される() throws {
        // Arrange
        let model = Model()
        
        // Act
        model.countUp()
        
        // Assert
        XCTAssertEqual(model.count, 1)
    }
    
    func test_Model_カウントがプラス10される() throws {
        // Arrange
        let model = Model()
        
        // Act
        for _ in 1..<11 {
            model.countUp()
        }
        
        // Assert
        XCTAssertEqual(model.count, 10)
    }
    
    func test_Controller_マイナス関数が呼ばれる() throws {
        // Arrange
        // Modelのモック関数をインスタンス化
        let model = MockModel()
        // ModelのモックをDependency Injectionする
        let controller = Controller.init(myModel: model)
        
        // Act
        controller.onMinusTapped()
        
        // Assert
        XCTAssertTrue(model.result)
    }
    
    func test_Controller_プラス関数が呼ばれる() throws {
        // Arrange
        // Modelのモック関数をインスタンス化
        let model = MockModel()
        // ModelのモックをDependency Injectionする
        let controller = Controller.init(myModel: model)
        
        // Act
        controller.onPlusTapped()
        
        // Assert
        XCTAssertTrue(model.result)
    }
    
    // Modelのモック
    class MockModel: ModelProtocol {
        var result = false

        func countDown() {
            result = true
        }
        
        func countUp() {
            result = true
        }
    }
    
    func test_View_画面が表示されたらラベルに0が表示される() {
        // Arrange
        // Act
        // Assert
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
