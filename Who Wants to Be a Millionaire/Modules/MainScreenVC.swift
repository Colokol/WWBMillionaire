//
//  MainScreenVC.swift
//  Who Wants to Be a Millionaire
//
//  Created by Alexander Altman on 27.02.2024.
//

import UIKit

final class MainScreenVC: UIViewController {
    
    //MARK: - Dependencies
    let spacing: CGFloat = 12
    let rulesBtnSize: CGFloat = 32
    var bestSumLabelValue: Int = 15000
    
    let quizManager = QuizManager()
    let mockManager = MockService.shared
    private lazy var gameViewController = QuestionViewController(
        quizManager: quizManager,
        dataManager: mockManager
    )
    
    //MARK: - UI Elements
    
    private lazy var background: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.bg
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var rulesButton: UIButton = {
        let element = UIButton(type: .system)
        element.setImage(UIImage(systemName: "questionmark.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        element.tintColor = .white
        element.addTarget(self, action: #selector(rulesBtnTapped), for: .touchUpInside)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainLogoVStack: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.distribution = .fill
        element.alignment = .center
        element.spacing = 16
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
       
    private lazy var subHStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        element.alignment = .center
        element.spacing = 2
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var logoImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.logo
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainLogoLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 2
        element.textAlignment = .center
        element.font = .boldSystemFont(ofSize: 32)
        element.text = "Who Wants to be a Millionaire"
        element.textColor = .white
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var subBestLabel: UILabel = {
        let element = UILabel()
        element.numberOfLines = 1
        element.textAlignment = .center
        element.font = .boldSystemFont(ofSize: 16)
        element.text = "All-time Best Score"
        element.textColor = .gray
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var coinImageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.coin
        element.contentMode = .scaleAspectFit
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var bestValueLabel: UILabel = {
        let element = UILabel()
        element.textColor = .white
        element.text = "$\(bestSumLabelValue)"
        element.font = .boldSystemFont(ofSize: 24)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var continueGameBtn = UIButton(bgImage: UIImage.orgbtn, name: "Continue game", target: self, action: #selector(continueBtnTapped))
    private lazy var newGameBtn = UIButton(bgImage: UIImage.blubtn, name: "New Game", target: self, action: #selector(newGameBtnTapped))
    
    private lazy var teamButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("© Team #2 by DevRush XI", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(devButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //!!!: Logic for new game vs continue game UI elements
//        hideElements()
    }
    
    //MARK: - Methods
    func hideElements() {
        continueGameBtn.isHidden = true
        subBestLabel.isHidden = true
        subHStackView.isHidden = true
    }
    
    //MARK: - Private Methods
    private func setupViews() {
        view.addSubview(background)
        view.addSubview(rulesButton)
        view.addSubview(mainLogoVStack)
        
        mainLogoVStack.addArrangedSubview(logoImageView)
        mainLogoVStack.addArrangedSubview(mainLogoLabel)
        mainLogoVStack.addArrangedSubview(subBestLabel)
        mainLogoVStack.addArrangedSubview(subHStackView)

        subHStackView.addArrangedSubview(coinImageView)
        subHStackView.addArrangedSubview(bestValueLabel)
        
        view.addSubview(continueGameBtn)
        view.addSubview(newGameBtn)
        view.addSubview(teamButton)
    }
    
    //MARK: - @Objc Methods
    @objc private func rulesBtnTapped() {
        let rulesVC = RulesViewController()
        rulesVC.modalPresentationStyle = .fullScreen
        present(rulesVC, animated: true)
    }
    
    @objc private func continueBtnTapped() {
        //continue game logic
        print("continue game")
    }

    @objc private func newGameBtnTapped() {
        gameViewController.modalPresentationStyle = .fullScreen
        present(gameViewController, animated: true)
    }
    
    @objc private func devButtonTapped() {
        let modalVC = DevelopersViewController()
        let navigationController = UINavigationController(rootViewController: modalVC)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true, completion: nil)
    }

}

//MARK: - Constraints
private extension MainScreenVC {
    func setConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rulesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rulesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing),
            rulesButton.heightAnchor.constraint(equalToConstant: rulesBtnSize),
            rulesButton.widthAnchor.constraint(equalTo: rulesButton.heightAnchor),
            
            mainLogoVStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing),
            mainLogoVStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing),
            mainLogoVStack.heightAnchor.constraint(equalToConstant: view.frame.height / 2),
            mainLogoVStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLogoVStack.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            
            coinImageView.widthAnchor.constraint(equalToConstant: 24),
            coinImageView.heightAnchor.constraint(equalToConstant: 24),
            
            continueGameBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing * 2),
            continueGameBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing * 2),
            continueGameBtn.bottomAnchor.constraint(equalTo: newGameBtn.topAnchor, constant: -spacing),
            continueGameBtn.heightAnchor.constraint(equalToConstant: view.frame.height / 12),
            
            newGameBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing * 2),
            newGameBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing * 2),
            newGameBtn.bottomAnchor.constraint(equalTo: teamButton.topAnchor, constant: -spacing * 3),
            newGameBtn.heightAnchor.constraint(equalToConstant: view.frame.height / 12),
            
           teamButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           teamButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }
}
