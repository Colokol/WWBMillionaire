//
//  QuizManager.swift
//  Who Wants to Be a Millionaire
//
//  Created by Vasilii Pronin on 28.02.2024.
//

import Foundation

protocol IQuizManager {

    /// Индекс текущего вопроса
    var currentIndex: Int {get set}

    /// Состояние игры
    var gameState: GameState {get set}

    /// Сумма для показа на экране результата
    var amountToShow: Int {get }

    /// Уровень для отражения в таблице результатов
    var levelToShowInTable: Int { get }

    /// Уровень для отражения на экране результатов
    var levelToShowInResults: Int { get }

    /// Уровень текущаей несгораемой суммы
    var guaranteedSumLevel: Int { get }

    /// Проверяет верность ответа
    /// - Parameters:
    ///   - index: индекс кнопки нажатой пользователем
    ///   - model: модель данных
    /// - Returns: верность ответа
    func checkAnswer(by index: Int, with model: Question.ViewModel) -> Bool
}

final class QuizManager: IQuizManager {

    let amounts = [
        0,
        500,
        1000,
        2000,
        3000,
        5000,
        7500,
        10000,
        12500,
        15000,
        25000,
        50000,
        100000,
        250000,
        500000,
        1000000
    ]

    var gameState = GameState.notStarted

    var currentIndex = 0 {
        didSet {
            guaranteedSumLevel = (currentIndex / 5) * 5
        }
    }

    var amountToShow: Int {
        if gameState == .finishGame {
            return amounts[currentIndex]
        } else {
            return amounts[guaranteedSumLevel]
        }
    }

    var levelToShowInTable: Int {
        switch gameState {
        case .correctAnswer:
            currentIndex + 1
        case .wrongAnswer:
            if currentIndex == 0 {
                0
            } else {
                guaranteedSumLevel
            }
        case .finishGame:
            currentIndex
        default:
            0
        }
    }

    var levelToShowInResults: Int {
        switch gameState {
        case .correctAnswer:
            currentIndex + 1
        case .wrongAnswer:
            currentIndex
        case .finishGame:
            currentIndex
        default:
            -1
        }
    }

    var guaranteedSumLevel = 0

    func checkAnswer(by index: Int, with model: Question.ViewModel) -> Bool {
        return model.allAnswers.firstIndex(of: model.correctAnswer) == index
    }

}
