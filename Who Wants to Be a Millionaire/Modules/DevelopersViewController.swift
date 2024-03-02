//
//  DevelopersScreen.swift
//  Who Wants to Be a Millionaire
//
//  Created by Alexander Altman on 02.03.2024.
//

import UIKit

class DevelopersViewController: UIViewController {
   
    //MARK: - UI Elements
    private lazy var background: UIImageView = {
        let element = UIImageView()
        element.image = UIImage.bg
        element.alpha = 0.95
        element.contentMode = .scaleAspectFill
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Team #2 Developers"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.sizeToFit()
        return label
    }()
    
    private lazy var namesStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .vertical
        element.spacing = 5
        element.distribution = .fillEqually
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    lazy var dev1Name = UILabel(name: "🎩Team's Leader - Uladzislau Yatskevich", target: self, action: #selector(labelTapped1))
    lazy var dev2Name = UILabel(name: "🍻Team's Buddy - Alexander Altman", target: self, action: #selector(labelTapped2))
    lazy var dev3Name = UILabel(name: "🙏🏼Team's Apologizer - Vitaliy Molokov", target: self, action: #selector(labelTapped3))
    lazy var dev4Name = UILabel(name: "🧠Team's Logician - Vesily92", target: self, action: #selector(labelTapped4))
    lazy var dev5Name = UILabel(name: "💣Team's Weapon - Nikita Tyschenko", target: self, action: #selector(labelTapped5))
    lazy var dev6Name = UILabel(name: "💐Team's Blossom - Aliya Kolesnikova", target: self, action: #selector(labelTapped6))
    lazy var dev7Name = UILabel(name: "👻Team's Mistery' - Zhaniya Medetkhan", target: self, action: #selector(labelTapped7))
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setViews()
        setConstraints()
    }
    
    //MARK: - Setups
    private func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        let closeBarButtonItem = UIBarButtonItem(title: "Close",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(dismissModal))
        closeBarButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = closeBarButtonItem
    }
    
    private func setViews() {
        view.addSubview(background)
        view.addSubview(namesStackView)
        let names = [dev1Name, dev2Name, dev3Name, dev4Name, dev5Name, dev6Name, dev7Name]
        names.forEach { name in
            namesStackView.addArrangedSubview(name)
        }
    }
    
    //MARK: - @Objc Methods
    @objc private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func labelTapped1() {
        if let url = URL(string: "https://github.com/Colokol") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func labelTapped2() {
        if let url = URL(string: "https://github.com/Qewhouse") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func labelTapped3() {
        if let url = URL(string: "https://github.com/molokovVV") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func labelTapped4() {
        if let url = URL(string: "https://github.com/vesily92") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func labelTapped5() {
        if let url = URL(string: "https://github.com/Onethousandman") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func labelTapped6() {
        if let url = URL(string: "https://github.com/AliyaHeula") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func labelTapped7() {
        if let url = URL(string: "https://github.com/medetkhanzhaniya") {
            UIApplication.shared.open(url)
        }
    }
}

private extension UILabel {
    convenience init(name: String, target: Any?, action: Selector) {
        self.init()
        self.text = name
        self.font = .boldSystemFont(ofSize: 16)
        self.textColor = .white
        self.textAlignment = .center
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: target, action: action))
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

private extension DevelopersViewController {
    func setConstraints() {
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            namesStackView.widthAnchor.constraint(equalToConstant: view.frame.width - 40),
            namesStackView.heightAnchor.constraint(equalToConstant: view.frame.height / 3),
            namesStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            namesStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
