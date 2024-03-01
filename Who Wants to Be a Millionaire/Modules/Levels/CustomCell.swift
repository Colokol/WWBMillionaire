//
//  CustomCell.swift
//  Who Wants to Be a Millionaire
//
//  Created by Виталик Молоков on 27.02.2024.
//

import UIKit

class MoneyLevelCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    private lazy var levelLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFCompactDisplay-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFCompactDisplay-Bold", size: 18) ?? UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var backgroundCellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayouts()
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setups
    
    private func setupView() {
        contentView.addSubview(backgroundCellImageView)
        contentView.addSubview(levelLabel)
        contentView.addSubview(amountLabel)
    }
    
    private func setupLayouts() {
        NSLayoutConstraint.activate([
            backgroundCellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundCellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundCellImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            backgroundCellImageView.widthAnchor.constraint(equalToConstant: 311)
        ])
        
        NSLayoutConstraint.activate([
            levelLabel.centerYAnchor.constraint(equalTo: backgroundCellImageView.centerYAnchor),
            levelLabel.leadingAnchor.constraint(equalTo: backgroundCellImageView.leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            amountLabel.centerYAnchor.constraint(equalTo: backgroundCellImageView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: backgroundCellImageView.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupCell() {
        backgroundColor = .clear // Установка прозрачного фона для ячейки
        selectionStyle = .none // Отключение выделения ячейки при нажатии
    }
    
    // MARK: - Methods
    
    // Метод для конфигурации ячейки
    func configureCell(level: Int, amount: String) {
        levelLabel.text = "\(level):"
        amountLabel.text = amount
        
        let nonBurnableBackground = "nonburnableLevel"
        let victoryBackground = "victoryLevel"
        let regularBackground = "regularLevel"
        
        var backgroundImageName: String
        switch level {
        case 5, 10:
            backgroundImageName = nonBurnableBackground
        case 15:
            backgroundImageName = victoryBackground
        default:
            backgroundImageName = regularBackground
        }
        backgroundCellImageView.image = UIImage(named: backgroundImageName)
    }
}

