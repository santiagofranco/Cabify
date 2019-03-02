//
//  ProductSummaryTableViewCell.swift
//  CabifyTest
//
//  Created by Santi on 02/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

class ProductSummaryTableViewCell: UITableViewCell {

    static let identifier = "ProductSummaryTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func bind(product: ProductSummary) {
        nameLabel.text = product.name
        countLabel.text = "\(product.count)"
        totalLabel.text = "\(product.total)"
    }
    
}
