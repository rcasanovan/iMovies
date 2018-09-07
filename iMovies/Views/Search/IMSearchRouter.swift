//
//  IMSearchRouter.swift
//  iMovies
//
//  Created by Ricardo Casanova on 06/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMSearchRouter {
    
    private let view: IMSearchViewInjection
    private var reachabilityView: IMGeneralMessageViewController?
    
    private var iShowingNotReachable: Bool = false
    
    init(view: IMSearchViewInjection) {
        self.view = view
    }
    
}

extension IMSearchRouter: IMSearchRouterDelegate {
    
    func showReachabilityStatus(show: Bool) {
        if show && !iShowingNotReachable {
            iShowingNotReachable = true
            reachabilityView = IMGeneralMessageViewController()
            guard let view = view as? IMSearchViewController, let reachabilityView = reachabilityView else {
                return
            }
            view.present(reachabilityView, animated: true, completion: nil)
        }
        
        if !show && iShowingNotReachable {
            iShowingNotReachable = false
            reachabilityView?.dismiss(animated: true, completion: nil)
        }
    }
    
}
