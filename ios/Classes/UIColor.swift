//
//  Copyright © 2018-2023 PSPDFKit GmbH. All rights reserved.
//
//  THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY INTERNATIONAL COPYRIGHT LAW
//  AND MAY NOT BE RESOLD OR REDISTRIBUTED. USAGE IS BOUND TO THE PSPDFKIT LICENSE AGREEMENT.
//  UNAUTHORIZED REPRODUCTION OR DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES.
//  This notice may not be removed from this file.
//


import UIKit

extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat

        if hexString.hasPrefix("#") {
            let start = hexString.index(hexString.startIndex, offsetBy: 1)
            let hexColor = String(hexString[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
            else if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255

                    self.init(red: r, green: g, blue: b, alpha: 255)
                    return
                }
            }
        }

        return nil
    }


    public static func colorFromName(_ name: String) -> UIColor? {
        let selector = Selector("\(name)Color")
        if UIColor.self.responds(to: selector) {
            let color = UIColor.self.perform(selector).takeUnretainedValue()
            return (color as! UIColor)
        }
        return nil
    }

    public static func rgb(_ colorValue: String) -> UIColor? {
        let colorsComponentString: String = colorValue.replacingOccurrences(of: "rgb(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "")
        let colorComponents = colorsComponentString.components(separatedBy: ",")
        let red = CGFloat((colorComponents[0] as NSString).floatValue)
        let green = CGFloat((colorComponents[1] as NSString).floatValue)
        let blue = CGFloat((colorComponents[2] as NSString).floatValue)
        return UIColor(
            red: red > 1 ? red/255 : red,
            green: green > 1 ? green/255 : green,
            blue: blue > 1 ? blue/255 : blue,
            alpha: 1
        )
    }

    public static func rgba(_ colorValue: String) -> UIColor? {
        let colorsComponentString: String = colorValue.replacingOccurrences(of: "rgba(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "")
        let colorComponents = colorsComponentString.components(separatedBy: ",")
        let red = CGFloat((colorComponents[0] as NSString).floatValue)
        let green = CGFloat((colorComponents[1] as NSString).floatValue)
        let blue = CGFloat((colorComponents[2] as NSString).floatValue)
        let alpha = CGFloat((colorComponents[3] as NSString).floatValue)
        return UIColor(
            red: red > 1 ? red/255 : red,
            green: green > 1 ? green/255 : green,
            blue: blue > 1 ? blue/255 : blue,
            alpha: alpha
        )
    }
}
