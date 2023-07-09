//
//  UserViewController.swift
//  MVVMWithTests
//
//  Created by Catherine Shing on 7/8/23.
//

import UIKit

class UserViewController: UIViewController, UserViewModelOutput {
    
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
    
  private let viewModel: UserViewModel
  
  init(viewModel: UserViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
    self.viewModel.output = self
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    fetchUsers()
  }
  
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        ])
        
        emailLabel.numberOfLines = 0
        emailLabel.backgroundColor = .lightGray
    }
  
  private func fetchUsers() {
    viewModel.fetchUser()
  }
  
    // MARK: - UserViewModelOutput
    func updateView(imageUrl: String, email: String) {
        DispatchQueue.global().async {
            if let url = URL(string: imageUrl),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.emailLabel.text = email
                }
            }
        }
    }
}
