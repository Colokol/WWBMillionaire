//
//  QuestionViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 26.02.2024.
//

import UIKit

final class QuestionViewController: UIViewController {
    var timerStop = 29

    var helpAvailibility: [HelpButton:Bool] = [
        HelpButton.fiftyFifty: true,
        HelpButton.audience: true,
        HelpButton.call: true
    ]

    private lazy var gameView = GameView(question: "What year was the year, when first deodorant was invented in our life?",
                                         answers: ["1", "2", "3", "4"], 
                                         helpAvailibility: helpAvailibility)

    // MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)

        gameView.onHelpButtonTapped = { [weak self] (_ button: HelpButton) -> () in
            guard let self else { return }
            self.helpAvailibility[button] = false
            self.helpButtonAction()
        }

        gameView.onCheckAnswer = {[weak self] (_ index: Int) -> () in
            guard let self else { return }
            self.checkAnswer(buttonIndex: index)
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func loadView() {
        view = gameView

    }

    // Temporary timer
    override func viewDidLoad() {
        DispatchQueue.global().async { [weak self] in
            guard let self else { return }
            while self.timerStop > 0 {
                sleep(1)
                self.timerStop -= 1
                self.gameView.timer.seconds = timerStop
            }
        }
    }

    // MARK: Selector methods

    @objc func helpButtonAction() {
        // help button logic
    }

    @objc func checkAnswer(buttonIndex: Int) {
        // answers check logic

        // Temporary:
        gameView.answersStack.changeAnswerColor(index: buttonIndex, correctAnswer: true)
        gameView.answersStack.disableAll(except: buttonIndex)
    }
}
