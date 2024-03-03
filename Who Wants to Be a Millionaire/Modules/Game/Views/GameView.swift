//
//  GameView.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 26.02.2024.
//

import UIKit

final class GameView: UIView {

    private let backgroundImage: UIImageView = {
        let image = GameImages.background.gameImage()
        return UIImageView(image: image)
    }()

    let timer = TimerView()

    private let questionLabel: UITextView = {
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        $0.textAlignment = .center
        $0.isUserInteractionEnabled = false
        $0.isScrollEnabled = true
        return $0
    }(UITextView())

    var answersStack: AnswersStack!

    var onHelpButtonTapped: ((HelpButton) -> ())?
    var onCheckAnswer: ((Int) -> ())?

    var helpAvailibility = [HelpButton: Bool]()
    lazy var fiftyFiftyButton = HelpButton.fiftyFifty.setButton(isEnabled: helpAvailibility[.fiftyFifty])
    lazy var audienceButton = HelpButton.audience.setButton(isEnabled: helpAvailibility[.audience])
    lazy var callButton = HelpButton.call.setButton(isEnabled: helpAvailibility[.call])
    private let buttonsStack: UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 24
        return $0
    }(UIStackView())

    // MARK: Initialization

    init(question: String,
         answers: [String],
         helpAvailibility: [HelpButton: Bool]) {
        self.helpAvailibility = helpAvailibility
        super.init(frame: CGRect.zero)
        questionLabel.text = question
        answersStack = AnswersStack(answers: answers)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: Lifecycle

    override func layoutSubviews() {
        configureButtonStack()
        configureAnswersStack()
        setSubview()
        setConstraints()
    }
    
    func updateView(with model: Question.ViewModel) {
        subviews.forEach { view in
            if view === answersStack {
                view.removeFromSuperview()
            }
        }
        questionLabel.text = model.question
        
        answersStack = AnswersStack(answers: model.allAnswers)
        answersStack.translatesAutoresizingMaskIntoConstraints = false
        configureAnswersStack()
        addSubview(answersStack)
        timer.seconds = 29
    }

    private func configureButtonStack() {
        [fiftyFiftyButton, audienceButton, callButton].forEach { button in
            buttonsStack.addArrangedSubview(button)
        }
        fiftyFiftyButton.addTarget(self, action: #selector(helpButtonPushed), for: .touchUpInside)
        audienceButton.addTarget(self, action: #selector(helpButtonPushed), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(helpButtonPushed), for: .touchUpInside)
    }

    private func configureAnswersStack() {
        for index in 0...3 {
            let button = answersStack.subviews[index] as? AnswerVariant
            button?.addTarget(self, action: #selector(checkAnswer), for: .touchUpInside)
        }
    }

    private func setSubview() {
        [backgroundImage, timer, questionLabel, answersStack, buttonsStack].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),

            timer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            timer.widthAnchor.constraint(equalToConstant: 91),
            timer.centerXAnchor.constraint(equalTo: centerXAnchor),

            questionLabel.topAnchor.constraint(equalTo: timer.bottomAnchor, constant: 32),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            questionLabel.heightAnchor.constraint(equalToConstant: 147),

            answersStack.heightAnchor.constraint(equalToConstant: 272),
            answersStack.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -40),
            answersStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            answersStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),

            buttonsStack.heightAnchor.constraint(equalToConstant: 64),
            buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -60),
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 37.5),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -37.5),
        ])
    }

    // MARK: Selector methods

    @objc func helpButtonPushed(sender: UIButton) {
        sender.isEnabled = false
        var button: HelpButton {
            switch sender {
            case buttonsStack.subviews[0]: return HelpButton.fiftyFifty
            case buttonsStack.subviews[1]: return HelpButton.audience
            case buttonsStack.subviews[2]: return HelpButton.call
            default: return HelpButton.audience
            }
        }
        onHelpButtonTapped?(button)
    }

    @objc func checkAnswer(sender: AnswerVariant) {
        guard let buttonIndex = answersStack.arrangedSubviews.firstIndex(where: { $0 == sender}) else { return }
        onCheckAnswer?(buttonIndex)
    }
}
