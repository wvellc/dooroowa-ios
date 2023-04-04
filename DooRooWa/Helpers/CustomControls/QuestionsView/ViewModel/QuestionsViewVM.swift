//
//  QuestionsViewVM.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 4/4/23.
//

import Foundation

protocol QuestionsProtocol {
    var currentQuestion: Observable<QuestionModel?> { get set }
    var arrQuestions: Observable<[QuestionModel]> { get set }
}
class QuestionsViewVM: NSObject, QuestionsProtocol {
    //MARK: - Variables
     
    var currentQuestion: Observable<QuestionModel?> = Observable(nil)
    var arrQuestions: Observable<[QuestionModel]> = Observable([])
    var currentIndex = 0
    
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
        arrQuestions = Observable(arrTemp)
        if arrQuestions.value.count > 0 {
            currentQuestion = Observable(arrQuestions.value.first)
        }
    }
    
    func nextQuestion() {
        if currentIndex + 1
            > arrQuestions.value.count {
            currentIndex += 1
            currentQuestion = Observable(arrQuestions.value[currentIndex])
        } else {
            print("Finish")
        }
    }
    
    func previousQuestion() {
        if currentIndex - 1
            >= 0 {
            currentIndex -= 1
            currentQuestion = Observable(arrQuestions.value[currentIndex])
        } else {
            print("Start")
        }
    }
}
