//
//  LoanTableViewController.swift
//  JSONSerialization
//
//  Created by Catherine Shing on 2/24/23.
//

import UIKit

class LoanTableViewController: UITableViewController {
    private let loanURL = "https://api.kivaws.org/v1/loans/newest.json"
    private var loans = [Loan]()
    
    enum Section {
        case all
    }
    
    lazy var dataSource = configureDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLatestLoans()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLatestLoans() {
        guard let loanUrl = URL(string: loanURL) else {
            return
        }
        
        let request = URLRequest(url: loanUrl)
        
        //  data task to retrieve contents from API
        //  Once the request completes, it returns the data (as well as errors) by calling the completion handler.
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                self.loans = self.parseJsonData(data: data)
                
                // Update table view's data
                OperationQueue.main.addOperation({
                    self.updateSnapshot()
                })
            }
        })
        
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Loan] {
        
        var loans = [Loan]()
        
        do {
            // capable of converting JSON to Foundation objects and converting Foundation objects to JSON
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            
            // Parse JSON data
            let jsonLoans = jsonResult?["loans"] as! [AnyObject]
            for jsonLoan in jsonLoans {
                var loan = Loan()
                loan.name = jsonLoan["name"] as! String
                loan.amount = jsonLoan["loan_amount"] as! Int
                loan.use = jsonLoan["use"] as! String
                let location = jsonLoan["location"] as! [String:AnyObject]
                loan.country = location["country"] as! String
                loans.append(loan)
            }
            
        } catch {
            print(error)
        }
        
        return loans
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, Loan> {

        let cellIdentifier = "Cell"

        let dataSource = UITableViewDiffableDataSource<Section, Loan>(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, loan in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! LoanTableViewCell

                cell.nameLabel.text = loan.name
                cell.countryLabel.text = loan.country
                cell.useLabel.text = loan.use
                cell.amountLabel.text = "$\(loan.amount)"

                return cell
            }
        )

        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Loan>()
        snapshot.appendSections([.all])
        snapshot.appendItems(loans, toSection: .all)

        dataSource.apply(snapshot, animatingDifferences: animatingChange)
    }
}
