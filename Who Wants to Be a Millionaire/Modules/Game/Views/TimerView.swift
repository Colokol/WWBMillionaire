//
//  TimerView.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 29.02.2024.
//

import UIKit

final class TimerView: UIStackView {

    var seconds = 29 {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.setNeedsLayout()
                self.layoutIfNeeded()
            }
        }
    }

    private let clockImage = UIImageView(image: GameImages.SF.timer.symbol(ofSize: 24))
    private var secondsLabel = UILabel()

    // MARK: Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .whiteWithAlpha
        layer.cornerRadius = 20
        axis = .horizontal
        spacing = 2.5

        secondsLabel.text = "29"
        secondsLabel.textColor = .whiteGame
        secondsLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        secondsLabel.textAlignment = .right

        clockImage.tintColor = .whiteGame
        
        layoutMargins = UIEdgeInsets(top: 10.5, left: 16, bottom: 10.5, right: 16)
        isLayoutMarginsRelativeArrangement = true

        [clockImage, secondsLabel].forEach {
            addArrangedSubview($0)
        }

        NSLayoutConstraint.activate([
            clockImage.heightAnchor.constraint(equalToConstant: 24),
            clockImage.widthAnchor.constraint(equalToConstant: 24),
        ])
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func layoutSubviews() {
        self.secondsLabel.text = "\(self.seconds)"
        if self.seconds == 15 {
            backgroundColor = .orangeWithAlpha
            clockImage.tintColor = .orangeGame
            secondsLabel.textColor = .orangeGame
        } else if self.seconds == 5 {
            backgroundColor = .redWithAlpha
            clockImage.tintColor = .redGame
            secondsLabel.textColor = .redGame
        }
    }

}
