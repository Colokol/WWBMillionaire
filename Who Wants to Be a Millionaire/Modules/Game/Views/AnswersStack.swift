//
//  AnswersStack.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 01.03.2024.
//

import UIKit

/// Стек с кнопками вариантов ответов
final class AnswersStack: UIStackView {

    private var answers = [""]
    private let varinats = ["A", "B", "C", "D"]

    init(answers: [String]) {
        self.answers = answers
        super.init(frame: CGRect.zero)

        for index in 0...3 {
            let button = AnswerVariant()
            button.letterLabel.text = "\(varinats[index]): "
            button.answerLabel.text = answers[index]
            addArrangedSubview(button)
        }
        axis = .vertical
        spacing = 16
        distribution = .fillEqually
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //    MARK: Game methods

    func fiftyFiftyHelp(firstIndex: Int, secondIndex: Int) {
        let firstAnswer = arrangedSubviews[firstIndex] as? AnswerVariant
        firstAnswer?.answerLabel.text = ""
        let secondAnswer = arrangedSubviews[secondIndex] as? AnswerVariant
        secondAnswer?.answerLabel.text = ""
    }

    func changeAnswerColor(index: Int, correctAnswer: Bool) {
        let answer = arrangedSubviews[index] as? AnswerVariant
        let backgroundImage =
        correctAnswer
        ? GameImages.correctAnswer.gameImage()
        : GameImages.wrongAnswer.gameImage()
        answer?.setBackgroundImage(backgroundImage, for: .normal)
    }

    func disableAll(except excludeIndex: Int) {
        for index in 0...3 where index != excludeIndex {
            let answer = arrangedSubviews[index] as? AnswerVariant
            answer?.isEnabled = false
        }
    }
}

///Конфигурация кнопок вариантов ответов
final class AnswerVariant: UIButton {
    let letterLabel = UILabel()
    let answerLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setBackgroundImage(GameImages.regularAnswer.gameImage(), for: .normal)

        letterLabel.textColor = .answerVariant
        letterLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)

        answerLabel.textColor = .whiteGame
        answerLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        answerLabel.textAlignment = .left
        answerLabel.numberOfLines = 2

        [letterLabel, answerLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            letterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            letterLabel.widthAnchor.constraint(equalToConstant: 17),
            letterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            answerLabel.leadingAnchor.constraint(equalTo: letterLabel.trailingAnchor, constant: 8),
            answerLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            answerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
