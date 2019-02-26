//
//  ProductListViewController.swift
//  CabifyTest
//
//  Created by Santi on 26/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var summaryButton: UIButton!
    
    var delegate: ProductListViewDelegate?
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupNavigationItem()
        setupSummaryView()
        
        self.delegate?.viewDidLoad()
    }
    
    fileprivate func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(with: ProductTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
    
    fileprivate func setupNavigationItem() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "products_list_title".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "products_list_refresh".localized(),
            style: .plain,
            target: self,
            action: #selector(didTapRefresh))
    }
    
    @objc fileprivate func didTapRefresh() {
        self.delegate?.didTapRefresh()
    }
    
    fileprivate func setupSummaryView() {
        summaryView.layer.shadowColor = UIColor.black.cgColor
        summaryView.layer.shadowOpacity = 0.5
        summaryView.layer.shadowOffset = .zero
        summaryView.layer.shadowRadius = 10
        
        totalTitleLabel.text = "products_list_total_title".localized() + ":"
        payButton.setTitle("products_list_pay_button".localized(), for: .normal)
        summaryButton.setTitle("products_list_summary_button".localized(), for: .normal)
        totalLabel.text = "0.0€"
        
        payButton.setTitleColor(.white, for: .normal)
        payButton.layer.backgroundColor = UIColor.purple.cgColor
        payButton.layer.cornerRadius = payButton.frame.height / 2
    }
    
    @IBAction func didTapRetry(_ sender: Any) {
        self.delegate?.didTapRetry()
    }
    
    @IBAction func didTapPayButton(_ sender: Any) {
        self.delegate?.didTapPay()
    }
    
    @IBAction func didTapSummaryButton(_ sender: Any) {
        self.delegate?.didTapSeeSummary()
    }
    
    fileprivate func updateLoading(showing: Bool) {
        activityIndicator.isHidden = !showing
        tableView.isHidden = showing
    }
    
    
}

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: ProductTableViewCell = tableView.dequeue(at: indexPath, identifier: ProductTableViewCell.identifier)
        cell.bind(product: products[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didTapProduct(products[indexPath.row])
    }
}

extension ProductListViewController: ProductTableViewCellDelegate {
    func didTapAddButton(cell: ProductTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        self.delegate?.didTapProduct(products[indexPath.row])
    }
}

extension ProductListViewController: ProductListViewProtocol {
    
    func showNoInternetConnectionError() {
        
    }
    
    func showLoading() {
        updateLoading(showing: true)
    }
    
    func showProducts(_ products: [Product]) {
        self.products = products
        tableView.reloadData()
    }
    
    func showDataErrorMessage() {
        
    }
    
    func hideLoading() {
        updateLoading(showing: false)
    }
    
    func showTotal(_ total: Double) {
        totalLabel.text = "\(total)€" //Currency could come from backend
    }
    
    func showPaymentSuccessMessage() {
        
    }
    
    func showNotEnoughBalanceError() {
        
    }
    
    
}
