//
//  UIColor+Extension.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 29.02.2024.
//

import UIKit

extension UIColor {
    convenience init(hex: String) {
        let r, g, b, a: CGFloat

        let scanner = Scanner(string: hex)
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)

        r = CGFloat((hexNumber & 0xff0000) >> 16) / 255.0
        g = CGFloat((hexNumber & 0xff00) >> 8) / 255.0
        b = CGFloat(hexNumber & 0xff) / 255.0
        a = 1.0

        self.init(red: r, green: g, blue: b, alpha: a)
        return
    }

    static var whiteGame = UIColor(hex: "FFFFFF")
    static var whiteWithAlpha = UIColor(hex: "FFFFFF").withAlphaComponent(0.1)
    static var orangeGame = UIColor(hex: "FFB340")
    static var orangeWithAlpha = UIColor(hex: "FFA800").withAlphaComponent(0.3)
    static var redGame = UIColor(hex: "FF6231")
    static var redWithAlpha = UIColor(hex: "832203").withAlphaComponent(0.5)
    static var answerVariant = UIColor(hex: "E19B30")


}
