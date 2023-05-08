//
//  MatrixVC.swift
//  CoordinateSystem
//
//  Created by Vova Novosad on 14.03.2023.
//

import UIKit

protocol MatrixDelegate: AnyObject {
    func transformTriangle(matrix: [[Int?]])
}

class MatrixVC: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: MatrixDelegate?
    
    private lazy var firstTextField: UITextField = {
        let textField = Utilities().textFieldSettings("1")
        
        return textField
    }()
    
    private lazy var secondTextField: UITextField = {
        let textField = Utilities().textFieldSettings("2")
        
        return textField
    }()
    
    private lazy var thirdTextField: UITextField = {
        let textField = Utilities().textFieldSettings("3")
        
        return textField
    }()
    
    private lazy var fourthTextField: UITextField = {
        let textField = Utilities().textFieldSettings("4")
        
        return textField
    }()
    
    private lazy var fifthTextField: UITextField = {
        let textField = Utilities().textFieldSettings("5")
        
        return textField
    }()
    
    private lazy var sixthTextField: UITextField = {
        let textField = Utilities().textFieldSettings("6")
        
        return textField
    }()
    
    private lazy var transformButton: UIButton = {
        let button = UIButton()
        button.setTitle("Transform", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(transformPressed), for: .touchUpInside)
        button.backgroundColor = .red
        button.setDimensions(width: 100, height: 40)
        button.layer.cornerRadius = 40 / 2
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc func transformPressed() {
        let first = Int(firstTextField.text ?? "0")
        let second = Int(secondTextField.text ?? "0")
        let third = Int(thirdTextField.text ?? "0")
        let fourth = Int(fourthTextField.text ?? "0")
        let fifth = Int(fifthTextField.text ?? "0")
        let sixth = Int(sixthTextField.text ?? "0")


        let matrix = [[first, second],
                      [third, fourth],
                      [fifth, sixth]]
        delegate?.transformTriangle(matrix: matrix)
        
        dismiss(animated: true)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let stackRight = UIStackView(arrangedSubviews: [firstTextField, thirdTextField, fifthTextField])
        stackRight.axis = .vertical
        stackRight.spacing = 6
        let stackLeft = UIStackView(arrangedSubviews: [secondTextField, fourthTextField, sixthTextField])
        stackLeft.axis = .vertical
        stackLeft.spacing = 6

        
        let stack = UIStackView(arrangedSubviews: [stackRight, stackLeft])

        view.addSubview(stack)
        stack.axis = .horizontal
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 5, paddingRight: 100)
        
        view.addSubview(transformButton)
        transformButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 30)
        
        
    }
    


}
