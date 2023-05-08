

import UIKit

protocol AddPointDelegate: AnyObject {
    func newPoint(point: Point)
}

class AddPointVC: UIViewController {
    
    //MARK: - Properties
    
    weak var deelgate: AddPointDelegate?
    
    private lazy var xContainerView: UIView = {
        let email = Utilities().inputContainerView(textField: xTextField)
        
        return email
    }()
    
    private lazy var yContainerView: UIView = {
        let password = Utilities().inputContainerView(textField: yTextField)
        
        return password
    }()
    
    private lazy var xTextField: UITextField = {
        let textField = Utilities().textFieldSettings("X")
        
        return textField
    }()
    
    private lazy var yTextField: UITextField = {
        let textField = Utilities().textFieldSettings("Y")
        
        return textField
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        button.backgroundColor = .red
        button.setDimensions(width: 100, height: 40)
        button.layer.cornerRadius = 40 / 2
        
        return button
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    //MARK: - Selectors
    
    @objc private func addButtonPressed() {
        guard let x = Int(xTextField.text ?? "") else { return }
        guard let y = Int(yTextField.text ?? "") else { return }
        let point = Point(x, y)
        deelgate?.newPoint(point: point)
        dismiss(animated: true)
    }
    
    //MARK: - Functionality
    
    private func configureUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [xContainerView, yContainerView])
        view.addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 5
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(addButton)
        addButton.centerX(inView: view, topAnchor: stack.bottomAnchor, paddingTop: 30)
    }

}
