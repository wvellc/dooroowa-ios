//
//  QuestionsViewVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import Foundation
import Combine

class QuestionsViewVM: NSObject {
    //MARK: - Variables
     
    var currentQuestion = CurrentValueSubject<QuestionModel?, Never>(nil)
    var arrQuestions = CurrentValueSubject<[QuestionModel], Never>([])
    
    private var currentIndex = 0
    
    override init() {
        /* Initial setup when view load */
        super.init()
        doInitialSettings()
    }
    
    deinit {
        print("Questions View Model released from memory")
    }

    //MARK: - Class Functions
    
    /// Initial settings when view loads
    fileprivate func doInitialSettings() {
        fetchQuestions()
    }
    
    func fetchQuestions() {
        var arrTemp = [QuestionModel]()
        for indx in 1...5 {
            let obj = QuestionModel(id: indx, question: "", description: "")
            arrTemp.append(obj)
        }
        arrQuestions.send(arrTemp)
        if arrQuestions.value.count > 0 {
            currentQuestion.send(arrQuestions.value.first)
        }
    }
    
    func nextQuestion() {
        if currentIndex + 1
            > arrQuestions.value.count {
            currentIndex += 1
            currentQuestion.send(arrQuestions.value[currentIndex])
        } else {
            print("Finish")
        }
    }
    
    func previousQuestion() {
        if currentIndex - 1
            >= 0 {
            currentIndex -= 1
            currentQuestion.send(arrQuestions.value[currentIndex])
        } else {
            print("Start")
        }
    }
}
