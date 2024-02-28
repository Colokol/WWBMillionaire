//
//  QuestionModel.swift
//  Who Wants to Be a Millionaire
//
//  Created by Vasilii Pronin on 28.02.2024.
//

import Foundation

enum Question {
    
    struct DTO: Decodable {
        
        let difficulty: String
        let question: String
        let correctAnswer: String
        let incorrectAnswers: [String]
    }
    
    struct ViewModel {
        
        let questionIndex: Int
        let question: String
        let correctAnswer: String
        let allAnswers: [String]
    }
}
