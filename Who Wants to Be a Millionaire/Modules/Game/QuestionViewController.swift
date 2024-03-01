//
//  QuestionViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 26.02.2024.
//

import UIKit
import MediaPlayer

final class QuestionViewController: UIViewController {
    
    private var timer: Timer?
    private var timerStop = 29

    let sound = Sound.shared
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        makeTimer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sound.play(.thinking)
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
        //some logic
        return (0, 2)
    }

    private func audienceHelpLogic() {
        //some logic
    }

    private func callHelpLogic() {
        //some logic
    }

    func checkAnswer(buttonIndex: Int) {
        let correctAnswer = quizManager.checkAnswer(
            by: buttonIndex,
            with: models[currentQuestionIndex]
        )
        sound.play(.accepted)
        gameView.answersStack.disableAll(except: buttonIndex)
        sleep(5)
        self.gameView.answersStack.changeAnswerColor(index: buttonIndex, correctAnswer: correctAnswer)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if correctAnswer {
                if currentQuestionIndex == 14 {
                    sound.play(.win)
                    dismiss(animated: true)
                } else {
                    sound.play(.correctAnswer)
                    self.quizManager.saveSum(with: self.models[self.currentQuestionIndex])
                    self.currentQuestionIndex += 1
                }
                self.gameView.updateView(with: self.models[self.currentQuestionIndex])
                self.makeTimer()
            } else {
                sound.play(.wrongAnswer)
                sleep(1)
                self.finishGame()
            }
            sleep(3)
        }
    }

    // MARK: Selector methods

    @objc func finishGame() {
        sound.stop()
        dismiss(animated: true)
    }
}
