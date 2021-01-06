//
//  Questions.swift
//  Edutainment
//
//  Created by Effy Zhang on 1/5/21.
//

import SwiftUI

struct Questions {
    var questions = [Question]()
    init(level: Int, quizCount: Int) {
        questions = createQuestions(level: level, quizCount: quizCount)
    }
    
    func createQuestions(level: Int, quizCount: Int) -> [Question] {
        var currentQuestions = [Question]()
        for(0..< quizCount){
            let tableSize = (level+1)*3
            let firstNum = Int.random(in: 1..<tableSize)
            let secondNum = Int.random(in: 1..<tableSize)
            let questionText = String("\(firstNum) * \(secondNum)")
            let correctAnswer = String(firstNum*secondNum)
            let question = Question(text: questionName, answer: correctAnswer )
            currentQuestions.append(question)
            print(
        }
        
        return currentQuestions
    }
}
