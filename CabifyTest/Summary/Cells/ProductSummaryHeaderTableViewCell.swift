//
//  ProductSummaryHeaderTableViewCell.swift
//  CabifyTest
//
//  Created by Santi on 02/03/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

class ProductSummaryHeaderTableViewCell: UITableViewCell {

    static let identifier = "ProductSummaryHeaderTableViewCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        nameLabel.text = "summary_header_name".localized()
        countLabel.text = "summary_header_count".localized()
        totalLabel.text = "summary_header_total".localized()
    }
}
