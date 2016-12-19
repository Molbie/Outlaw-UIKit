//
//  UIColor+Outlaw.h
//  OutlawExtensions
//
//  Created by Brian Mullen on 12/11/16.
//  Copyright © 2016 Molbie LLC. All rights reserved.
//


#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
import Outlaw
import OutlawCoreGraphics


public extension UIColor {
    public struct ExtractableKeys {
        public static let red = "red"
        public static let green = "green"
        public static let blue = "blue"
        public static let alpha = "alpha"
    }
    public struct ExtractableIndexes {
        public static let red: Int = 0
        public static let green: Int = 1
        public static let blue: Int = 2
        public static let alpha: Int = 3
    }
}

extension UIColor: Value {
    public static func value(from object: Any) throws -> UIColor {
        if let data = object as? Extractable {
            typealias keys = UIColor.ExtractableKeys
            
            let red: CGFloat = try data.value(for: keys.red)
            let green: CGFloat = try data.value(for: keys.green)
            let blue: CGFloat = try data.value(for: keys.blue)
            let alpha: CGFloat? = data.value(for: keys.alpha)
            
            return UIColor(red: red, green: green, blue: blue, alpha: alpha ?? 1)
        }
        else if let data = object as? IndexExtractable {
            typealias indexes = UIColor.ExtractableIndexes
            
            let red: CGFloat = try data.value(for: indexes.red)
            let green: CGFloat = try data.value(for: indexes.green)
            let blue: CGFloat = try data.value(for: indexes.blue)
            let alpha: CGFloat? = data.value(for: indexes.alpha)
            
            return UIColor(red: red, green: green, blue: blue, alpha: alpha ?? 1)
        }
        else {
            let expectedType = "Extractable or IndexExtractable"
            throw OutlawError.typeMismatch(expected: expectedType, actual: type(of: object))
        }
    }
}

extension UIColor: Serializable {
    public func serialized() -> [String: CGFloat] {
        typealias keys = UIColor.ExtractableKeys
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var result = [String: CGFloat]()
        result[keys.red] = red
        result[keys.green] = green
        result[keys.blue] = blue
        result[keys.alpha] = alpha
        
        return result
    }
}
#endif
