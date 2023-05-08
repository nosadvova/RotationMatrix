//
//  ConnectPointsVC.swift
//  CoordinateSystem
//
//  Created by Vova Novosad on 13.03.2023.
//

import UIKit

protocol ConnectPointsDelegate: AnyObject {
    func connectPoints(points: Int)
}

class ConnectPointsVC: UIViewController {
    
    //MARK: - Properties
    
    weak var delegate: ConnectPointsDelegate?
    
    private lazy var pointsContainerView: UIView = {
        let email = Utilities().inputContainerView(textField: pointsTextField)
        
        return email
    }()
    
    private lazy var pointsTextField: UITextField = {
        let textField = Utilities().textFieldSettings("Count of points to connnect")
        
        return textField
    }()
    
    private lazy var connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(connectButtonPressed), for: .touchUpInside)
        button.backgroundColor = .twitterBlue
        button.setDimensions(width: 100, height: 40)
        button.layer.cornerRadius = 40 / 2
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc private func connectButtonPressed() {
        guard let count = Int(pointsTextField.text ?? "") else { return }
        delegate?.connectPoints(points: count)
        dismiss(animated: true)
    }
    
    //MARK: - Functionality
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(pointsContainerView)
        pointsContainerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(connectButton)
        connectButton.centerX(inView: view, topAnchor: pointsContainerView.bottomAnchor, paddingTop: 30)
    }
    


}
