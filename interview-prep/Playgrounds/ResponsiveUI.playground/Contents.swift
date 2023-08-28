import UIKit
import PlaygroundSupport

// Build a login/sign up form programmatically in UIKit

//class ExampleController: UIViewController {
//    let emailTextField: UITextField = {
//           let textField = UITextField()
//           textField.placeholder = "Email"
//           return textField
//       }()
//
//       let passwordTextField: UITextField = {
//           let textField = UITextField()
//           textField.placeholder = "Password"
//           textField.isSecureTextEntry = true
//           return textField
//       }()
//
//       let loginButton: UIButton = {
//           let button = UIButton(type: .system)
//           button.setTitle("Login", for: .normal)
//           button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
//           return button
//       }()
//
//       let signUpButton: UIButton = {
//           let button = UIButton(type: .system)
//           button.setTitle("Sign Up", for: .normal)
//           return button
//       }()
//
//    @objc func loginButtonTapped() {
//        print("Button tapped!")
//    }
//
//       // MARK: - View Lifecycle
//
//       override func viewDidLoad() {
//           super.viewDidLoad()
//
//           self.view.bounds = CGRect(x: 0, y: 0, width: 375, height: 667)
//
//           setupUI()
//           setupConstraints()
//       }
//
//       // MARK: - UI Setup
//
//       private func setupUI() {
//           view.addSubview(emailTextField)
//           view.addSubview(passwordTextField)
//           view.addSubview(loginButton)
//           view.addSubview(signUpButton)
//       }
//
//       private func setupConstraints() {
//           let safeLayoutGuide = view.safeAreaLayoutGuide
//
//           let horizontalStackView = UIStackView(arrangedSubviews: [loginButton, signUpButton])
//           horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
//
//           horizontalStackView.axis = .horizontal
//           horizontalStackView.spacing = 50
//
//           let verticalStackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, horizontalStackView])
//           verticalStackView.axis = .vertical
//           verticalStackView.spacing = 20
//           verticalStackView.translatesAutoresizingMaskIntoConstraints = false
//
//           view.addSubview(verticalStackView)
//
//           NSLayoutConstraint.activate([
////               verticalStackView.topAnchor.constraint(equalTo: safeLayoutGuide.topAnchor, constant: 30),
//               verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//               verticalStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//           ])
//       }
//}

// Build a simple tableview with static data

class TableViewExampleController: UIViewController, UITableViewDataSource, UITableViewDelegate {

     var names:[String] = [ "Dusty","Teddy","Pepe"]

     override func viewDidLoad() {
         super.viewDidLoad()
         self.view.bounds = CGRect(x: 0, y: 0, width: 375, height: 667)
         
         self.tableView.dataSource = self
         self.tableView.delegate = self
         
         setupContraints()
     }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          names.count
     }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->  UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)

          let name = names[indexPath.row]
          cell.textLabel?.text = name
          return cell
     }
    
    func setupContraints() {
        self.view.addSubview(self.tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

//PlaygroundPage.current.liveView = ExampleController()

PlaygroundPage.current.liveView = TableViewExampleController()
