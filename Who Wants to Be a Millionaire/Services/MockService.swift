//
//  MockService.swift
//  Who Wants to Be a Millionaire
//
//  Created by Vasilii Pronin on 28.02.2024.
//

import Foundation

protocol IMockService {
    func fetchQuiz(_ completion: @escaping (([Question.ViewModel]) -> Void))
}

final class MockService {
    
    static var shared = MockService()
    
    private init() {}
    
    private func map(_ data: [Question.DTO]) -> [Question.ViewModel] {
        let easyQuestions = data.filter { $0.difficulty == "easy" }
        let mediumQuestions = data.filter { $0.difficulty == "medium" }
        let hardQuestions = data.filter { $0.difficulty == "hard" }
        
        let rawQuiz = [
            easyQuestions,
            mediumQuestions,
            hardQuestions
        ].flatMap { $0 }
        
        var models: [Question.ViewModel] = []
        
        rawQuiz.enumerated().forEach {
            models.append(
                makeModel(with: $0.element, questionIndex: $0.offset)
            )
        }
        return models
    }
    
    private func makeModel(
        with data: Question.DTO,
        questionIndex: Int
    ) -> Question.ViewModel {
        let question = data.question
        
        var allAnswers = data.incorrectAnswers
        allAnswers.append(data.correctAnswer)
        allAnswers.shuffle()
        
        return Question.ViewModel(
            questionIndex: questionIndex,
            question: question,
            correctAnswer: data.correctAnswer,
            allAnswers: allAnswers
        )
    }
}

extension MockService: IMockService {
    
    func fetchQuiz(_ completion: @escaping (([Question.ViewModel]) -> Void)) {
        let rawQuiz = Bundle.main.decode([Question.DTO].self, from: "Quiz.json")
        completion(map(rawQuiz))
    }
}
