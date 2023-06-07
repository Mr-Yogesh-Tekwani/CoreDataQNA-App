//
//  SecondViewController.swift
//  Question Answer App
//
//  Created by Dhiraj on 6/6/23.
//

import UIKit

class SecondViewController: UIViewController {
    
    var allData : [QNA] = []
    
    var index = 0
    
    let ql : UILabel = {
        let l = UILabel()
        l.textColor = .white
        l.backgroundColor = .black
        return l
    }()
    
    let op1 : UIButton = {
        let q = UIButton()
        q.tintColor = .systemRed
        q.backgroundColor = .lightGray
        q.addTarget(self, action: #selector(checkAns), for: .touchUpInside)
        return q
    }()
    
    let op2 : UIButton = {
        let q = UIButton()
        q.tintColor = .systemRed
        q.backgroundColor = .gray
        q.addTarget(self, action: #selector(checkAns), for: .touchUpInside)
        return q
    }()
    
    let nextButton : UIButton = {
        let q = UIButton()
        q.setTitle("Next", for: .normal)
        q.tintColor = .white
        q.backgroundColor = .green
        q.addTarget(self, action: #selector(nextQuestion), for: .touchUpInside)
        return q
    }()
    
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stack.addArrangedSubview(ql)
        stack.addArrangedSubview(op1)
        stack.addArrangedSubview(op2)
        stack.addArrangedSubview(nextButton)
        nextButton.isHidden = true
        self.view.addSubview(stack)
        
        ql.text = allData[index].question
        let op1Text = allData[index].option1
        let op2Text = allData[index].option2
        let correctAns = allData[index].correctOption
        
        op1.setTitle(op1Text, for: .normal)
        op2.setTitle(op2Text, for: .normal)
        
        print(allData[index].question)
        print(allData[index].option1)
        print(allData[index].option2)
        print(allData[index].correctOption)
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeArea.topAnchor),
            stack.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            stack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
    }
    
    func showPopup() {
        let alertController = UIAlertController(title: "Correct Ans !", message: "Correct Ans", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print("OK button tapped")
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
    @objc func checkAns(_ sender: UIButton){
        let ca = allData[index].correctOption
        let selectedAns = sender.titleLabel?.text
        if selectedAns == ca {
            showPopup()
            nextButton.isHidden = false
        }
    }
    
    @objc func nextQuestion(){
        
        if index < allData.count-1{
            let svc = SecondViewController()
            svc.allData = allData
            svc.index = index + 1
            navigationController?.pushViewController(svc, animated: true)
        }
        else{
            navigationController?.popToRootViewController(animated: true)
        }
    }
    

}
