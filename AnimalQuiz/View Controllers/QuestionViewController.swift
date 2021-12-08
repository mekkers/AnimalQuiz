//
//  QuestionViewController.swift
//  AnimalQuiz
//
//  Created by igor mekkers on 01.12.2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answersCount = Float(questions[questionIndex].answers.count - 1)
            rangedSlider.maximumValue = answersCount
        }
    }
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rengedStackView: UIStackView!
    

    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var rangedLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    
    //MARK: Properties
    
    private let questions = Question.getQuestion()
    private var questionIndex = 0
    private var answerChosen: [Answer] = []
    private var currentAnswers: [Answer] { questions[questionIndex].answers
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let currentIndex = singleButtons.firstIndex(of: sender)
        else {
            return
        }
        let currentAnswer = currentAnswers[currentIndex]
        answerChosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleAnswerPressed() {
        for(multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChosen.append(answer)
            }
        }
        
        nextQuestion()
    }
    
    @IBAction func rangedAnswerButtonPressed() {
        let index = Int(rangedSlider.value)
        answerChosen.append(currentAnswers[index])
        
        nextQuestion()
    }
    
    
}

//MARK: - Private
extension QuestionViewController {
    private func updateUI() {
        // Hide stacks
        for stackView in [singleStackView,
                          multipleStackView, rengedStackView] {
            stackView?.isHidden = true
        }
        //get current question
        let currentQuestion = questions[questionIndex]
        
        //set current question for label
        questionLabel.text = currentQuestion.text
        
        //calculate progress
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        //set prigress for progress
        
        progressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        // show current StackView

        showCurrentStackView(for: currentQuestion.type)
    }
    
    
    private func showCurrentStackView(for type: ResponceType) {
        switch type {
        case .single:
           showSingleStackView(with: currentAnswers)
        case .multiple:
            showMultipleStackView(with: currentAnswers)
        case .range:
            showRangedStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.text
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rengedStackView.isHidden = false
        
        rangedLabels.first?.text = answers.first?.text
        rangedLabels.last?.text = answers.last?.text
    }
    
    private func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < questions.count {
            updateUI()
            return
        }
        
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
