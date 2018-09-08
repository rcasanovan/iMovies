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
    
    /**
     * Show loader
     *
     * - parameters:
     *      -show: show / hide the loader
     */
    public func showLoader(_ show: Bool) {
        show == true ? SVProgressHUD.show() : SVProgressHUD.dismiss()
    }
    
    /**
     * Show alert
     *
     * - parameters:
     *      -title: title for the aler
     *      -message: message for the alert
     *      -actionTitle: action title for the alert
     */
    public func showAlertWith(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(
            title: actionTitle,
            style: .default,
            handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     * Determinate if we need to use the safe area insets
     */
    public func useSafeAreaInsets() -> Bool {
        if #available(iOS 11.0, *) {
            // If we´re running iOS 11 && device type == iPhone X
            // -> use the save area insets
            if IMUtils.getDeviceType() == .iPhoneX {
                return true
            }
        }
        
        return false
    }
    
    /**
     * Get the safe area insets
     */
    public func getSafeAreaInsets() -> UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets
        }
        
        return .zero
    }
    
}
