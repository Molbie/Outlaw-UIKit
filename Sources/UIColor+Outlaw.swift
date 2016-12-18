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


extension UIColor: Value {
    public static func value(from object: Any) throws -> UIColor {
        if let data = object as? Extractable {
            let red: CGFloat = try data.value(for: "red")
            let green: CGFloat = try data.value(for: "green")
            let blue: CGFloat = try data.value(for: "blue")
            let alpha: CGFloat? = data.value(for: "alpha")
            
            return UIColor(red: red, green: green, blue: blue, alpha: alpha ?? 1)
        }
        else if let data = object as? IndexExtractable {
            let red: CGFloat = try data.value(for: 0)
            let green: CGFloat = try data.value(for: 1)
            let blue: CGFloat = try data.value(for: 2)
            let alpha: CGFloat? = data.value(for: 3)
            
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
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 1
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var result = [String: CGFloat]()
        result["red"] = red
        result["green"] = green
        result["blue"] = blue
        result["alpha"] = alpha
        
        return result
    }
}
#endif
