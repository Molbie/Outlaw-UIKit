//
//  UIColorTests.swift
//  OutlawUIKit
//
//  Created by Brian Mullen on 12/17/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(watchOS)
import XCTest
import Outlaw
import OutlawCoreGraphics
@testable import OutlawUIKit


class UIColorTests: XCTestCase {
    func testExtractableValue() {
        typealias keys = UIColor.ExtractableKeys
        
        let rawData: [String: CGFloat] = [keys.red: 0.1,
                                          keys.green: 0.2,
                                          keys.blue: 0.3,
                                          keys.alpha: 0.4]
        let data: [String: [String: CGFloat]] = ["color": rawData]
        let color: UIColor = try! data.value(for: "color")
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(red, rawData[keys.red])
        XCTAssertEqual(green, rawData[keys.green])
        XCTAssertEqual(blue, rawData[keys.blue])
        XCTAssertEqual(alpha, rawData[keys.alpha])
    }
    
    func testIndexExtractableValue() {
        let rawData: [CGFloat] = [0.1, 0.2, 0.3, 0.4]
        let data: [[CGFloat]] = [rawData]
        let color: UIColor = try! data.value(for: 0)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(red, rawData[0])
        XCTAssertEqual(green, rawData[1])
        XCTAssertEqual(blue, rawData[2])
        XCTAssertEqual(alpha, rawData[3])
    }
    
    func testInvalidValue() {
        let rawData: String = "Hello, Outlaw!"
        let data: [String] = [rawData]
        
        let ex = self.expectation(description: "Invalid data")
        do {
            let _: UIColor = try data.value(for: 0)
        }
        catch {
            if case OutlawError.typeMismatchWithIndex = error {
                ex.fulfill()
            }
        }
        self.waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSerializable() {
        typealias keys = UIColor.ExtractableKeys
        
        let color = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
        let data: [String: CGFloat] = color.serialized()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(data[keys.red], red)
        XCTAssertEqual(data[keys.green], green)
        XCTAssertEqual(data[keys.blue], blue)
        XCTAssertEqual(data[keys.alpha], alpha)
    }
}
#endif
