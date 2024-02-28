//
//  GameResultsViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Никита Тыщенко on 27.02.2024.
//

import UIKit

final class GameResultViewController: UIViewController {
    
    private let spacing: CGFloat = 12
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var resultsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var gameOverLabel: UILabel = {
        let label = UILabel()
        label.text = "Game over!"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()

    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "Level 8"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private lazy var scoreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 2
        return stackView
    }()
    
    private lazy var coinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "coin")
        return imageView
    }()
    
    private lazy var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "$15,000"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var newGamebutton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage.newGame, for: .normal)
        button.setTitle("New game", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var mainScreenbutton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage.mainScreen, for: .normal)
        button.setTitle("Main screen", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        view.addSubview(backgroundImageView)
        view.addSubview(logoImageView)
        view.addSubview(scoreStackView)
        view.addSubview(resultsStackView)
        view.addSubview(newGamebutton)
        view.addSubview(buttonStackView)
        
        scoreStackView.addArrangedSubview(coinImageView)
        scoreStackView.addArrangedSubview(scoreLabel)
   
        resultsStackView.addArrangedSubview(gameOverLabel)
        resultsStackView.addArrangedSubview(levelLabel)
        resultsStackView.addArrangedSubview(scoreStackView)
        
        buttonStackView.addArrangedSubview(newGamebutton)
        buttonStackView.addArrangedSubview(mainScreenbutton)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: spacing * 3),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            coinImageView.widthAnchor.constraint(equalToConstant: 40),
            coinImageView.heightAnchor.constraint(equalToConstant: 40),
            
            scoreStackView.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: spacing),
            scoreStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                        
            buttonStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: spacing * 2),
            buttonStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -spacing * 2),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -spacing * 6),
            
            mainScreenbutton.heightAnchor.constraint(equalToConstant: view.frame.height / 12),
            
            newGamebutton.heightAnchor.constraint(equalToConstant: view.frame.height / 12)
        ])
    }
}

