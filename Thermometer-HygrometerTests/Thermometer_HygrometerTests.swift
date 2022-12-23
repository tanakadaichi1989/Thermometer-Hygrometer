//
//  Thermometer_HygrometerTests.swift
//  Thermometer-HygrometerTests
//
//  Created by 田中大地 on 2022/12/17.
//

import XCTest
@testable import Thermometer_Hygrometer

final class Thermometer_HygrometerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let test1 = Double.convert(245, 1)
        XCTAssertNil(test1)
        
        let test2 = Double.convert(244, 1)
        XCTAssertEqual(test2,50.0)
        
        let test3 = Double.convert(243, 1)
        XCTAssertEqual(test3,49.9)
        
        let test4 = Double.convert(255, 0)
        XCTAssertEqual(test4,25.5)
        
        let test5 = Double.convert(0,1)
        XCTAssertEqual(test5,25.6)
        
        let test6 = Double.convert(1, 1)
        XCTAssertEqual(test6,25.7)
                
        let test7 = Double.convert(1, 0)
        XCTAssertEqual(test7,0.1)
        
        let test8 = Double.convert(0, 0)
        XCTAssertEqual(test8,0.0)
        
        let test9 = Double.convert(255,255)
        XCTAssertEqual(test9, -0.1)

        let test10 = Double.convert(156, 255)
        XCTAssertEqual(test10,-10.0)
                    
        let test11 = Double.convert(155, 255)
        XCTAssertNil(test11)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
