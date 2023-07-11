//
//  ViewController.swift
//  PassThroughSubjects
//
//  Created by Catherine Shing on 7/10/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private lazy var accountViewModel = AccountViewModel()
    private lazy var commentsViewModel = CommentsViewModel(accountVM: accountViewModel)
    
    private var subscriptions = Set<AnyCancellable>()

    private let commentTxtVw: UITextView = {
        let txtVw = UITextView()
        txtVw.layer.borderColor = UIColor.systemGray4.cgColor
        txtVw.layer.borderWidth = 1
        txtVw.layer.cornerRadius = 8
        txtVw.translatesAutoresizingMaskIntoConstraints = false
        return txtVw
    }()
    
    private let commentBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(commentDidTouch), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Comment", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let formContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillProportionally
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    
    override func loadView() {
        super.loadView()
        setup()
        accountSubscription()
    }
    
    @objc
    func commentDidTouch() {
        commentsViewModel.send(comment: commentTxtVw.text)
    }
}

private extension ViewController {
    
    func setup() {
        
        formContainerStackVw.addArrangedSubview(commentTxtVw)
        formContainerStackVw.addArrangedSubview(commentBtn)

        view.addSubview(formContainerStackVw)
        
        NSLayoutConstraint.activate([
                        
            commentBtn.heightAnchor.constraint(equalToConstant: 44),
            commentTxtVw.heightAnchor.constraint(equalToConstant: 150),
            formContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                          constant: 16),
            formContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                          constant: -16),
            formContainerStackVw.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                         constant: -44)
        ])
    }
    
    func accountSubscription() {
        accountViewModel
            .userAccountstatus
            .sink { [weak self] status in
                guard let self = self else { return }
                if status == .banned {
                    self.showBlocked()
                }
            }
            .store(in: &subscriptions)
    }
}
