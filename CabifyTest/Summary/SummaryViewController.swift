//
//  SummaryViewController.swift
//  CabifyTest
//
//  Created by Santi on 02/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

/**
 This class manages interface logic and user inputs.
 
 We use a protocol for this class, because we are injecting this implementation in the presenter.
 We can change easily this implementation without break nothing.
 */

class SummaryViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var totalLabel: UILabel!
    
    var products: [ProductSummary] = []
    var delegate: SummaryViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBlurBackground()
        
        container.clipsToBounds = true
        container.layer.cornerRadius = 30
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        titleLabel.text = "summary_title".localized()
        closeButton.setTitle("summary_close".localized(), for: .normal)
        closeButton.setTitleColor(.purple, for: .normal)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(with: ProductSummaryHeaderTableViewCell.identifier)
        tableView.registerCell(with: ProductSummaryTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        
        self.delegate?.viewDidLoad()
        
    }

    @IBAction func didTapClose(_ sender: Any) {
        self.delegate?.didTapClose()
        self.dismiss(animated: true, completion: nil)
    }
}

extension SummaryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell: ProductSummaryHeaderTableViewCell = tableView.dequeue(at: indexPath, identifier: ProductSummaryHeaderTableViewCell.identifier)
            return cell
            
        }
        
        let cell: ProductSummaryTableViewCell = tableView.dequeue(at: indexPath, identifier: ProductSummaryTableViewCell.identifier)
        cell.bind(product: products[indexPath.row - 1])
        return cell
        
    }
}

extension SummaryViewController: SummaryViewProtocol {
    
    func showProducts(_ products: [ProductSummary]) {
        self.products = products
        tableView.reloadData()
    }
    
    func showTotalDiscounted(_ total: Double) {
        totalLabel.text = String(format: "summary_total".localized(), total)
    }
    
}
