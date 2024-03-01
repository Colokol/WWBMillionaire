//
//  QuizManager.swift
//  Who Wants to Be a Millionaire
//
//  Created by Vasilii Pronin on 28.02.2024.
//

import Foundation

protocol IQuizManager {
    
    /// Текущая несгораемая сумма
    var guaranteedSum: Int { get }
    
    /// Возвращает сумму выигрыша за вопрос
    /// - Parameter index: индекс вопроса
    /// - Returns: сумма выигрыша
    func getSum(by index: Int) -> Int
    
    /// Проверяет верность ответа
    /// - Parameters:
    ///   - index: индекс кнопки нажатой пользователем
    ///   - model: модель данных
    /// - Returns: верность ответа
    func checkAnswer(by index: Int, with model: Question.ViewModel) -> Bool
    
    /// Обновляет несгораемую сумму
    /// - Parameter model: модель данных
    func saveSum(with model: Question.ViewModel)
}

final class QuizManager: IQuizManager {
    
    private let amounts = [
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
    
    var guaranteedSum = 0
    
    func getSum(by index: Int) -> Int {
        return amounts[index]
    }
    
    func checkAnswer(by index: Int, with model: Question.ViewModel) -> Bool {
        return model.allAnswers.firstIndex(of: model.correctAnswer) == index
    }
    
    func saveSum(with model: Question.ViewModel) {
        guard (model.questionIndex + 1) % 5 == 0 else {
            return
        }
        guaranteedSum = amounts[model.questionIndex]
    }
}
