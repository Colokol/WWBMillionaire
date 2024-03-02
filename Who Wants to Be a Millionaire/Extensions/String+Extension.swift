//
//  String+Extension.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 02.03.2024.
//

import Foundation

extension String {
    static func currencyFormatted(value: Int) -> String {
        let formatter: NumberFormatter = {
            $0.locale = Locale(identifier: "en_EN")
            $0.numberStyle = .currency
            $0.currencySymbol = "$"
            $0.usesGroupingSeparator = true
            $0.groupingSeparator = ","
            $0.maximumFractionDigits = 0
            return $0
        }(NumberFormatter())
        return (formatter.string(from: NSNumber(value: value)) ?? "")
    }
}
