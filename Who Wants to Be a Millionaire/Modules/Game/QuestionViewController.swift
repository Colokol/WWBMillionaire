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
    
    // MARK: Selector methods
    
    @objc func helpButtonAction() {
        // help button logic
    }
    
    @objc func checkAnswer(buttonIndex: Int) {
        // answers check logic
        let correctAnswer = quizManager.checkAnswer(
            by: buttonIndex,
            with: models[currentQuestionIndex]
        )
        
        gameView.answersStack.changeAnswerColor(index: buttonIndex, correctAnswer: correctAnswer)
        gameView.answersStack.disableAll(except: buttonIndex)
        
        if correctAnswer {
            quizManager.saveSum(with: models[currentQuestionIndex])
            currentQuestionIndex += 1
            
            gameView.updateView(with: models[currentQuestionIndex])
            makeTimer()
        }
    }
}
