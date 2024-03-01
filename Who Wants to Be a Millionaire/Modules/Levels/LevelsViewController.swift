//
//  LevelsViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Виталик Молоков on 26.02.2024.
//

import UIKit

class LevelsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    let levels = Array(Array(1...15).reversed())
    let amounts = ["$1,000,000", "$500,000", "$250,000", "$100,000", "$50,000", 
                   "$25,000", "$15,000", "$12,500", "$10,000", "$7,500", 
                   "$5,000", "$3,000", "$2,000", "$1,000", "$500"]
    
    // MARK: - UI Elements
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bigLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var listOfResult: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoneyLevelCell.self, forCellReuseIdentifier: "MoneyLevelCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        addTapGestureCloseView()
    }
    
    // MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(listOfResult)
        view.addSubview(logoImageView)
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            listOfResult.topAnchor.constraint(equalTo: view.topAnchor, constant: 146),
            listOfResult.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listOfResult.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listOfResult.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 76),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 85),
            logoImageView.heightAnchor.constraint(equalToConstant: 85),
            
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    // Метод закрытия по тапу
    private func addTapGestureCloseView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap))
        view.addGestureRecognizer(tapGesture)
    }

    //MARK: - Actions
    
    @objc private func handleScreenTap() {
        
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoneyLevelCell", for: indexPath) as! MoneyLevelCell
        let level = levels[indexPath.row]
        let amount = amounts[indexPath.row]
        cell.configureCell(level: level, amount: amount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
}


















