//
//  ModalViewController.swift
//  CabifyTest
//
//  Created by Santi on 27/02/2019.
//  Copyright © 2019 Santiago Franco. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    let message: String
    
    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBlurBackground()
        container.layer.cornerRadius = 10
        messageLabel.text = message
    }

    @IBAction func didTapOk(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
