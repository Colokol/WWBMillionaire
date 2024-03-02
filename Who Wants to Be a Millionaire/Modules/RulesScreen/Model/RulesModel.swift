//
//  RulesModel.swift
//  Who Wants to Be a Millionaire
//
//  Created by Alexander Altman on 02.03.2024.
//

import Foundation

struct RulesModel {
    let rules = """
The game Who wants to become a millionaire? - This is a quiz contest in which participants must correctly answer a series of multiple choice questions to advance to the next level. There are 15 questions in total, each question costs a certain amount of money. Participants also receive three types of tips to help themselves if they get stuck on a particular question.

Questions “Who wants to become a millionaire?” they are structured according to three different levels, with the difficulty level gradually increasing. Each level contains five questions.

Questions grouped at the same level will have the same difficulty. For example: Questions 1-5 make up the first level and will contain the simplest questions. The second level (questions 6-10) will be somewhat more difficult, followed by the last level (questions 11-15), which has the most difficult questions in the game.

It is important to remember that the questions that make up each level will not necessarily relate to the same or even similar topics, but their overall difficulty level will be the same.

=================
◉ Question 1 - $500
◉ Question 2 - $1.000
◉ Question 3 - $2.000
◉ Question 4 - $3.000
◉ Question 5 - $5.000
(Safe Sum)
=================
If the participants answer the last question incorrectly, they leave with nothing. If the correct answer is given to this question, participants are guaranteed $5.000, even if they give the wrong answer before reaching the next Safe Sum in the tenth question.
=================
◉ Question 6 - $7.500
◉ Question 7 - $10.000
◉ Question 8 - $12.500
◉ Question 9 - $15.000
◉ Question 10 - $25.000
(Safe Sum)
=================
If the participants answer this question incorrectly, they will leave with 1000 rubles. If this question is answered correctly, the players are guaranteed $25.000, even if they give the wrong answer before reaching the question 15.
=================
◉ Question 11 - $50.000
◉ Question 12 - $100.000
◉ Question 13 - $250.000
◉ Question 14 - $500.000
◉ Question 15 - $1.000.000 🏆
=================
Hints
Participants are allowed to apply three hints, which they can use at any time of the quiz. Each of the hints can only be used once.

◉ 50/50 - eliminates two incorrect answers from the multiple choice, leaving the participant with only one correct and one incorrect option. That means he has a 50/50 chance.

◉ Ask the audience a question - the audience is asked the same question as the participant, and a quick survey is conducted to show their answers. The diagram shows the clear advantage of a certain option, this hint can be extremely useful. The participant is given the opportunity to agree with the results received from the audience.

◉ Call a friend - Participants are allowed to make a 30-second call to a friend or family member and ask if they know the answer to the question.
"""
}
