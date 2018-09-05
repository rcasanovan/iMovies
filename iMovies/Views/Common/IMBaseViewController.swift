//
//  IMBaseViewController.swift
//  iMovies
//
//  Created by Ricardo Casanova on 05/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    public func showLoader(_ show: Bool) {
        show == true ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
    
}
