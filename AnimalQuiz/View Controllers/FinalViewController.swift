//
//  FinalViewController.swift
//  AnimalQuiz
//
//  Created by igor mekkers on 01.12.2021.
//

import UIKit

class FinalViewController: UIViewController {

  
    @IBOutlet var animalTypeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var answers: [Answer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        let maxAnimal = getMaxAnimal()
        updateUI(with: maxAnimal)

    }

}

// MARK: - Private Methods

extension FinalViewController {
    
    private func getMaxAnimal() -> AnimalType? {
        return Dictionary(grouping: answers, by: { $0.type })
            .sorted(by: { $0.value.count > $1.value.count})
            .first?.key
    }
    
    private func updateResult() {
        
       // var frequencyOfAnimals: [AnimalType: Int] = [:]
       // let animals = answers.map { $0.type }
        
      //  for animal in animals {
          //  if let animalTypeCount = frequencyOfAnimals[animal] {
              //  frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
           // } else {
             //   frequencyOfAnimals[animal] = 1
           // }
       // }
        
        //for animal in animals {
           // frequencyOfAnimals[animal] = (frequencyOfAnimals[animal] ?? 0) + 1
       // }
        
       // let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1,value }
        //guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        //Решение в одну строку
        
        
        
    }
    
    private func updateUI(with animal: AnimalType?) {
        animalTypeLabel.text = "Вы - \(animal?.rawValue ?? "🐶" )!"
        descriptionLabel.text = animal?.definition ?? ""
    }
    
}
