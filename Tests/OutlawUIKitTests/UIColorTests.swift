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
    fileprivate typealias keys = UIColor.ExtractableKeys
    fileprivate typealias indexes = UIColor.ExtractableIndexes
    
    func testExtractableValue() {
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
        var rawData = [CGFloat](repeating: 0, count: 4)
        rawData[indexes.red] = 0.1
        rawData[indexes.green] = 0.2
        rawData[indexes.blue] = 0.3
        rawData[indexes.alpha] = 0.4
        
        let data: [[CGFloat]] = [rawData]
        let color: UIColor = try! data.value(for: 0)
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(red, rawData[indexes.red])
        XCTAssertEqual(green, rawData[indexes.green])
        XCTAssertEqual(blue, rawData[indexes.blue])
        XCTAssertEqual(alpha, rawData[indexes.alpha])
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
        let color = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
        let data = color.serialized()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(data[keys.red], red)
        XCTAssertEqual(data[keys.green], green)
        XCTAssertEqual(data[keys.blue], blue)
        XCTAssertEqual(data[keys.alpha], alpha)
        
        let white = UIColor.white
        let data2 = white.serialized()
        white.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(data2[keys.red], red)
        XCTAssertEqual(data2[keys.green], green)
        XCTAssertEqual(data2[keys.blue], blue)
        XCTAssertEqual(data2[keys.alpha], alpha)
    }
    
    func testIndexSerializable() {
        let color = UIColor(red: 0.1, green: 0.2, blue: 0.3, alpha: 0.4)
        let data = color.serializedIndexes()
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(data[indexes.red], red)
        XCTAssertEqual(data[indexes.green], green)
        XCTAssertEqual(data[indexes.blue], blue)
        XCTAssertEqual(data[indexes.alpha], alpha)
        
        let white = UIColor.white
        let data2 = white.serializedIndexes()
        white.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        XCTAssertEqual(data2[indexes.red], red)
        XCTAssertEqual(data2[indexes.green], green)
        XCTAssertEqual(data2[indexes.blue], blue)
        XCTAssertEqual(data2[indexes.alpha], alpha)
    }
}
#endif
