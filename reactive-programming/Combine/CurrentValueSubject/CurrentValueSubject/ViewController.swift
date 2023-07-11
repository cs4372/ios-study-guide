//
//  ViewController.swift
//  CurrentValueSubject
//
//  Created by Catherine Shing on 7/10/23.
//

import UIKit
import Combine

class ViewController: UIViewController {

    private let firstNameTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "First Name"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let lastNameTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Last Name"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let occupationTxtField: UITextField = {
        let txtField = UITextField()
        txtField.translatesAutoresizingMaskIntoConstraints = false
        txtField.placeholder = "Occupation"
        txtField.borderStyle = .roundedRect
        return txtField
    }()
    
    private let confirmBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(confirmDidTouch), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Confirm", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let formContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillEqually
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    
    private let person = CurrentValueSubject<Person, Error>(Person(firstName: "", lastName: "", occupation: ""))
    
    private var subscriptions = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        setup()
        setupInputSubscriptions()
        setupPersonSubscription()
    }
    
    @objc
    func confirmDidTouch() {
        if person.value.isValid {
            person.send(completion: .finished)
        } else {
            self.showFailed(message: UserError.invalid.errorDescription)
        }
    }
}

private extension ViewController {
    
    func setup() {
        
        formContainerStackVw.addArrangedSubview(firstNameTxtField)
        formContainerStackVw.addArrangedSubview(lastNameTxtField)
        formContainerStackVw.addArrangedSubview(occupationTxtField)
        formContainerStackVw.addArrangedSubview(confirmBtn)

        view.addSubview(formContainerStackVw)
        
        NSLayoutConstraint.activate([
            formContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                          constant: 16),
            formContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -16),
            formContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            formContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        formContainerStackVw
            .arrangedSubviews
            .forEach { $0.heightAnchor.constraint(equalToConstant: 44).isActive = true }
    }
    
    func setupInputSubscriptions() {
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: firstNameTxtField)
            .compactMap({ ($0.object as? UITextField)?.text })
            .sink { [weak self] val in
                self?.person.value.firstName = val
            }
            .store(in: &subscriptions)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: lastNameTxtField)
            .compactMap({ ($0.object as? UITextField)?.text })
            .sink { [weak self] val in
                self?.person.value.lastName = val
            }
            .store(in: &subscriptions)
        
        NotificationCenter
            .default
            .publisher(for: UITextField.textDidChangeNotification, object: occupationTxtField)
            .compactMap({ ($0.object as? UITextField)?.text })
            .sink { [weak self] val in
                self?.person.value.occupation = val
            }
            .store(in: &subscriptions)
    }
    
    func setupPersonSubscription() {
        person
            .sink { _ in
                print("Final input: \(self.person.value.message ?? "")")
            } receiveValue: { person in
                print(person)
            }
            .store(in: &subscriptions)
    }
}
