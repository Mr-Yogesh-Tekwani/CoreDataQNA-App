//
//  ViewController.swift
//  Question Answer App
//
//  Created by Dhiraj on 6/6/23.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var allData : [QNA] = []
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let takeTest : UIButton = {
        let q = UIButton()
        q.setTitle("Take Test", for: .normal)
        q.tintColor = .systemRed
        q.backgroundColor = .green
        q.addTarget(self, action: #selector(goToTest), for: .touchUpInside)
        return q
    }()
    
    let addQuestion : UIButton = {
        let q = UIButton()
        q.setTitle("Add New Question", for: .normal)
        q.tintColor = .systemBlue
        q.backgroundColor = .gray
        q.addTarget(self, action: #selector(addNewQuestion), for: .touchUpInside)
        return q
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAllQuestions()
        stack.addArrangedSubview(takeTest)
        stack.addArrangedSubview(addQuestion)
        self.view.addSubview(stack)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    @objc func addNewQuestion(){
        createNewQuestion()
    }
    
    @objc func goToTest(){
        let svc = SecondViewController()
        svc.allData = allData
        navigationController?.pushViewController(svc, animated: true)
    }
    
    func showAlertWithTextFields(completion: @escaping (String, String, String, String) -> Void) {
        let alertController = UIAlertController(title: "Enter Values", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter Question"
            textField.delegate = self
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter Option 1"
            textField.delegate = self
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter Option 2"
            textField.delegate = self
        }
        
        alertController.addTextField { textField in
            textField.placeholder = "Enter Correct Option"
            textField.delegate = self
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let textFields = alertController.textFields,
                  textFields.count >= 4 else {
                completion("", "", "", "")
                return
            }
            
            let value1 = textFields[0].text ?? ""
            let value2 = textFields[1].text ?? ""
            let value3 = textFields[2].text ?? ""
            let value4 = textFields[3].text ?? ""
            
            completion(value1, value2, value3, value4)
        }
        
        alertController.addAction(saveAction)
        
        // Present the alert
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }



    func createNewQuestion(){
        let newQuestion = QNA(context: context)
        showAlertWithTextFields{ value1, value2, value3, value4 in
        newQuestion.question = value1
        newQuestion.option1 = value2
        newQuestion.option2 = value3
        newQuestion.correctOption = value4
        print(newQuestion)
        do{
            try self.context.save()
            self.showAllQuestions()
        } catch{
            print(error)
        }
      }
        
    }
    
    
    func checkCorrectAns(item: QNA, selectedAns: String) -> Bool {
        let ca = item.correctOption
        if selectedAns == ca{
            return true
        }
        else{
            return false
        }
    }

    func showAllQuestions(){
        do{
            allData = try context.fetch(QNA.fetchRequest())
            print("All data",allData.description)
        } catch{
            print(error)
        }
    }
    
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
