//
//  Images.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 26.02.2024.
//

import UIKit

enum GameImages: String {
    // MARK: Assets
    case background = "background"
    case regularAnswer = "regularAnswer"
    case correctAnswer = "correctAnswer"
    case wrongAnswer = "wrongAnswer"
    case helpEllipse = "helpEllipse"
    case coin = "coin"
    case currentLevel = "currentLevel"
    case backButton = "arrowBack"

    func gameImage() -> UIImage {
        UIImage(named: self.rawValue) ?? UIImage()
    }

    // MARK: SFSymbols
    enum SF: String {
        case timer = "timer"
        case helpAudience = "person.2.wave.2"
        case helpCall = "phone"

        func symbol(ofSize: CGFloat, withColor color: UIColor? = nil) -> UIImage {
            let configuration = UIImage.SymbolConfiguration(font: UIFont.boldSystemFont(ofSize: ofSize))
            guard let image = UIImage(systemName: self.rawValue, withConfiguration: configuration) else { return UIImage() }
            guard let color = color else { return image }
            return image.withTintColor(color)
        }
    }

}
