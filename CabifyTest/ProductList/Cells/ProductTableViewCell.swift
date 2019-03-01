//
//  ProductTableViewCell.swift
//  
//
//  Created by Santi on 26/02/2019.
//

import UIKit

protocol ProductTableViewCellDelegate: class {
    func didTapAddButton(cell: ProductTableViewCell)
}

class ProductTableViewCell: UITableViewCell {

    static let identifier = "ProductTableViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addLabel: UILabel!
    
    weak var delegate: ProductTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.5
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 10
        
        addLabel.text = "➕"
        addLabel.isUserInteractionEnabled = true
        addLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapAdd)))
    }
    
    @objc fileprivate func didTapAdd() {
        self.delegate?.didTapAddButton(cell: self)
    }
    
    func bind(product: Product) {
        nameLabel.text = product.name
        priceLabel.text = String(format: "%.2f€", product.price) //Currency could come from backend
    }

    
}
