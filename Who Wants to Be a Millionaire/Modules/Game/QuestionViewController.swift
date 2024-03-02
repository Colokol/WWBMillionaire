//
//  QuestionViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 26.02.2024.
//

import UIKit

final class QuestionViewController: UIViewController {
    
    private var timer: Timer?
    
    var timerStop = 29
    
    var helpAvailibility: [HelpButton:Bool] = [
        HelpButton.fiftyFifty: true,
        HelpButton.audience: true,
        HelpButton.call: true
    ]
    
    private let quizManager: IQuizManager
    private let dataManager: IMockService
    
    private var currentQuestionIndex = 0
    private var models: [Question.ViewModel] = []
    private var gameView: GameView!
    
    
    // MARK: Initialization
    
    init(quizManager: IQuizManager, dataManager: IMockService) {
        self.quizManager = quizManager
        self.dataManager = dataManager
        
        super.init(nibName: nil, bundle: nil)
        
        self.dataManager.fetchQuiz { [weak self] models in
            self?.models = models
        }
        
        setupGameView()
        gameView.coinButton.addTarget(self, action: #selector(finishGame), for: .touchUpInside)
        gameView.onHelpButtonTapped = { [weak self] (_ button: HelpButton) -> () in
            guard let self else { return }
            self.helpAvailibility[button] = false
            self.helpButtonAction(button)
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
        super.viewDidLoad()
        
        makeTimer()
    }


    private func makeTimer() {
        timer?.invalidate()
        
        timerStop = 29
        gameView.timer.seconds = timerStop
        
        timer = Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(resetTimer),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc private func resetTimer() {
        if timerStop > 0 {
            timerStop -= 1
            gameView.timer.seconds = timerStop
        } else {
            gameView.answersStack.disableAll()
        }
    }
    
    private func setupGameView() {
        let model = models[currentQuestionIndex]
        
        gameView = GameView(
            question: model.question,
            answers: model.allAnswers,
            helpAvailibility: helpAvailibility
        )
    }
    
    // MARK: Logic methods

    private func helpButtonAction(_ button: HelpButton) {
        switch button {
        case .fiftyFifty:
            let (firstExclude, secondExclude) = fiftyFiftyHelpLogic()
            gameView.answersStack.fiftyFiftyHelp(firstIndex: firstExclude, secondIndex: secondExclude)
        case .audience:
            audienceHelpLogic()
        case .call:
            callHelpLogic()
        }
    }

    private func fiftyFiftyHelpLogic() -> (Int, Int) {
        let model = models[currentQuestionIndex]
        let answers = model.allAnswers
        let correctAnswer = model.correctAnswer
        let firstIndex = answers.firstIndex { $0 != correctAnswer }!
        let secondIndex = answers.lastIndex { $0 != correctAnswer }!
        
        return (firstIndex, secondIndex)
    }

    private func audienceHelpLogic() {
        let model = models[currentQuestionIndex]
        var answer = model.correctAnswer
        
        let randomNumber = Int.random(in: 0...99)
        
        if randomNumber > 70 {
            let incorrectAnswers = model.allAnswers.filter { $0 != answer }
            answer = incorrectAnswers.randomElement() ?? ""
        }
        showAlert(withTitle: "Ответ зала", andMessage: answer)
    }

    private func callHelpLogic() {
        let model = models[currentQuestionIndex]
        var answer = model.correctAnswer
        
        let randomNumber = Int.random(in: 0...99)
        
        if randomNumber > 80 {
            let incorrectAnswers = model.allAnswers.filter { $0 != answer }
            answer = incorrectAnswers.randomElement() ?? ""
        }
        showAlert(withTitle: "Ответ друга", andMessage: answer)
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }

    func checkAnswer(buttonIndex: Int) {
        let correctAnswer = quizManager.checkAnswer(
            by: buttonIndex,
            with: models[currentQuestionIndex]
        )
        
        gameView.answersStack.changeAnswerColor(index: buttonIndex, correctAnswer: correctAnswer)
        gameView.answersStack.disableAll(except: buttonIndex)
        DispatchQueue.global().async {[weak self] in
            guard let self else { return }
            sleep(1)
            DispatchQueue.main.async {
                if correctAnswer {
                    self.quizManager.saveSum(with: self.models[self.currentQuestionIndex])
                    self.currentQuestionIndex += 1

                    self.gameView.updateView(with: self.models[self.currentQuestionIndex])
                    self.makeTimer()
                } else {
                    self.finishGame()
                }
            }
        }
    }

    // MARK: Selector methods

    @objc func finishGame() {
        dismiss(animated: true)
    }
}
