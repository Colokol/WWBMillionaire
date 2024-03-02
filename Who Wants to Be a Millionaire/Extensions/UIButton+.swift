//
//  UIButton+.swift
//  Who Wants to Be a Millionaire
//
//  Created by Alexander Altman on 02.03.2024.
//

import UIKit

extension UIButton {
    convenience init(bgImage: UIImage, name: String, target: Any?, action: Selector) {
        self.init()
        self.setBackgroundImage(bgImage, for: .normal)
        self.setTitle(name, for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .boldSystemFont(ofSize: 24)
        self.addTarget(target, action: action, for: .touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
