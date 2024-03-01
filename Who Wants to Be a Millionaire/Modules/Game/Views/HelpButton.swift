//
//  HelpButton.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 29.02.2024.
//

import UIKit

enum HelpButton {
    case fiftyFifty
    case audience
    case call

    private func buttonLabel(withColor color: UIColor) -> NSAttributedString {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]

        switch self {
        case .fiftyFifty:
            return NSAttributedString(string: "50:50", attributes: attributes)
        case .audience:
            return NSAttributedString(attachment: NSTextAttachment(image: GameImages.SF.helpAudience.symbol(ofSize: 32, withColor: color)))
        case .call:
            return NSAttributedString(attachment: NSTextAttachment(image: GameImages.SF.helpCall.symbol(ofSize: 32, withColor: color)))
        }
    }

    func setButton(isEnabled: Bool?) -> UIButton {
        let helpButton = UIButton()
        helpButton.setBackgroundImage(GameImages.helpEllipse.gameImage(), for: .normal)
        helpButton.setAttributedTitle(buttonLabel(withColor: .whiteGame), for: .normal)
        helpButton.setAttributedTitle(buttonLabel(withColor: .whiteWithAlpha), for: .disabled)

        if
            let isEnabled,
            !isEnabled {
            helpButton.isEnabled = false
        }
        return helpButton
    }
}
