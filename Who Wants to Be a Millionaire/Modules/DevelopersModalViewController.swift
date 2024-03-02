//
//  DevelopersModalViewController.swift
//  Who Wants to Be a Millionaire
//
//  Created by Виталик Молоков on 02.03.2024.
//

import UIKit

class DevelopersModalViewController: UIViewController {
    
    //MARK: - Properties
    
    let backgroundColor = UIColor(red: 49/255.0, 
                                  green: 52/255.0, 
                                  blue: 68/255.0, 
                                  alpha: 1.0)
    
    //MARK: - UI Elements
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Team 2"
       label.textColor = .white
       label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
       label.sizeToFit()
       return label
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        setupNavigationBar()
    }
    
    //MARK: - Setups
    
    private func setupNavigationBar() {
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", 
                                                           style: .plain, 
                                                           target: self, 
                                                           action: #selector(dismissModal))
    }
    
    //MARK: - Actions
    
    @objc private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}
