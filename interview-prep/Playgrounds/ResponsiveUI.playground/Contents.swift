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
// Selecting table cell should navigate to controller and display text name

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedName = names[indexPath.row]
        print("selectedName", selectedName)
        let viewNameController = ViewNameController()
        viewNameController.selectedName = selectedName
        let navigationController = UINavigationController(rootViewController: viewNameController)
        
        navigationController.modalPresentationStyle = .fullScreen
        
        /* Xcode
         viewNameController.selectedName = selectedName
          
        navigationController?.pushViewController(viewNameController, animated: true)
         */
        
        present(navigationController, animated: true, completion: nil)
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

class ViewNameController: UIViewController {
    var selectedName: String?
    
    private let nameLabel: UILabel = {
         let label = UILabel()
         label.textColor = .label
         label.textAlignment = .center
         label.font = .systemFont(ofSize: 16, weight: .regular)
         label.text = "Unknown"
         return label
     }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonTapped))
                
        if let selectedName = selectedName {
            nameLabel.text = selectedName
            nameLabel.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(nameLabel)
            
            NSLayoutConstraint.activate([
                nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
    }
    // doesn't work in playground
    
    @objc func backButtonTapped() {
         navigationController?.popViewController(animated: true)
     }
}

PlaygroundPage.current.liveView = TableViewExampleController()

//PlaygroundPage.current.liveView = ExampleController()
