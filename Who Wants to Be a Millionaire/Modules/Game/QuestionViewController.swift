//
//  QuestionViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Aliya on 26.02.2024.
//

import UIKit

enum GameState {
    case notStarted
    case correctAnswer
    case wrongAnswer
    case finishGame
    case win
}

final class QuestionViewController: UIViewController {
    
    private var timer: Timer?
    private var timerStop = 29

    private let sound = Sound.shared

    var gameState = GameState.notStarted {
        didSet {
            quizManager.gameState = gameState
        }
    }

    private var helpAvailibility: [HelpButton:Bool] = [
        HelpButton.fiftyFifty: true,
        HelpButton.audience: true,
        HelpButton.call: true
    ]
    
    private var quizManager: IQuizManager
    private let dataManager: IMockService
    
    private var currentQuestionIndex = 0
    private var models: [Question.ViewModel] = []
    private var gameView: GameView!

    private lazy var firstTitleLine: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = .whiteWithAlpha0_5
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private lazy var secondTitleLine: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .whiteGame
        $0.textAlignment = .center
        return $0
    }(UILabel())

    lazy var titles:UIStackView = {
        $0.axis = .vertical
        $0.addArrangedSubview(firstTitleLine)
        $0.addArrangedSubview(secondTitleLine)
        return $0
    }(UIStackView())

    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = GameImages.backButton.gameImage()
        button.setImage(image, for: .normal)
        return button
    }()

    let coinButton: UIButton = {
        $0.setImage(GameImages.coin.gameImage(), for: .normal)
        return $0
    }(UIButton())

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
    }

    override func loadView() {
        view = gameView
    }

    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        quizManager.currentIndex = currentQuestionIndex
        if currentQuestionIndex < 15 {
            gameView.updateView(with: models[currentQuestionIndex])
        }
        updateTitleText()
        makeTimer()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sound.play(.thinking)
    }

    override func viewDidDisappear(_ animated: Bool) {
        currentQuestionIndex += 1
        timer?.invalidate()
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
            gameState = .wrongAnswer
            closeQuestion()
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

    private func setupNavigationBarItems() {
        navigationItem.titleView = titles

        let leftBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftBarButton
        leftBarButton.customView?.widthAnchor.constraint(equalToConstant: 32).isActive = true
        leftBarButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        let rightBarButton = UIBarButtonItem(customView: coinButton)
        navigationItem.rightBarButtonItem = rightBarButton
        rightBarButton.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
        rightBarButton.customView?.heightAnchor.constraint(equalToConstant: 40).isActive = true
        coinButton.addTarget(self, action: #selector(coinButtonTapped), for: .touchUpInside)
    }

    private func updateTitleText() {
        firstTitleLine.text = "QESTION #\(quizManager.levelToShowInGame)"
        secondTitleLine.text = String.currencyFormatted(value: quizManager.amountToShowInGame)
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
        sound.play(.accepted)
        gameView.answersStack.disableAll(except: buttonIndex)
        sleep(5)
        self.gameView.answersStack.changeAnswerColor(index: buttonIndex, correctAnswer: correctAnswer)
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            if correctAnswer {
                if currentQuestionIndex == 14 {
                    gameState = .win
                    sound.play(.win)
                } else {
                    sound.play(.correctAnswer)
                    self.gameState = .correctAnswer
                }
            } else {
                sound.play(.wrongAnswer)
                self.gameState = .wrongAnswer
            }
            self.closeQuestion()
        }
    }

    // MARK: Selector methods

    @objc func coinButtonTapped() {
        sound.play(.win)
        gameState = .finishGame
        closeQuestion()
    }

    func closeQuestion() {
        sleep(1)
        var viewControllerToShow: UIViewController
        if currentQuestionIndex == 0 && gameState == .wrongAnswer {
            viewControllerToShow = GameResultViewController(quizManager: quizManager)
        } else {
            viewControllerToShow = LevelsViewController(quizManager: quizManager)
        }
        let nextScreenNavigation = UINavigationController(rootViewController: viewControllerToShow)
        nextScreenNavigation.modalPresentationStyle = .fullScreen
        present(nextScreenNavigation, animated: true)
    }

    @objc func backButtonTapped() {
        sound.stop()
        dismiss(animated: true)
    }
}
