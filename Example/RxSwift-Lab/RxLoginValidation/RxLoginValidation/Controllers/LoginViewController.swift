//
//  LoginViewController.swift
//  RxLoginValidation
//
//  Created by taehy.k on 2021/05/07.
//

import UIKit
import MaterialComponents.MaterialTextControls_OutlinedTextFields
import MaterialComponents.MaterialButtons
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    let viewModel = LoginViewModel()
    let disposeBag = DisposeBag()
    
    private lazy var idTextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "id"
        tf.placeholder = "Enter your id"
        tf.leadingAssistiveLabel.text = "This is where enter your id"
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return tf
    }()
    
    private lazy var pwTextField: MDCOutlinedTextField = {
        let tf = MDCOutlinedTextField()
        tf.label.text = "pw"
        tf.placeholder = "Enter your pw"
        tf.leadingAssistiveLabel.text = "This is where enter your pw"
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.sizeToFit()
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private lazy var loginButton: MDCButton = {
        let bt = MDCButton()
        bt.setTitle("login", for: .normal)
        bt.setBackgroundColor(.purple)
        bt.isUserInteractionEnabled = false
        bt.alpha = 0.3
        return bt
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [idTextField,pwTextField,loginButton])
        stack.axis = .vertical
        stack.spacing = 50
        return stack
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // your code
        configureUI()
        configureKeyboard()
        loginBind()
    }
}


// MARK: - Helpers
extension LoginViewController {
    
    // MARK: - Configures
    
    func configureKeyboard() {
        dismissKeyboardWhenTappedAround()
        moveViewWhenKeyboardAppearOrDisappeared()
    }

    func configureUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
    }
    
    // MARK: - Binds
    func loginBind() {
        self.idTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.idPublishSubject)
            .disposed(by: disposeBag)
        
        self.pwTextField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.pwPublishSubject)
            .disposed(by: disposeBag)
        
        viewModel.isValid().subscribe(onNext: { valid in
            self.loginButton.isUserInteractionEnabled = valid
            if valid {
                self.loginButton.alpha = 1
            } else {
                self.loginButton.alpha = 0.3
            }
        })
        .disposed(by: disposeBag)
    }
}
