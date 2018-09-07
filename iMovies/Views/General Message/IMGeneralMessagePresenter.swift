//
//  IMGeneralMessagePresenter.swift
//  iMovies
//
//  Created by Ricardo Casanova on 07/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

class IMGeneralMessagePresenter {
    
    private weak var view: IMGeneralMessageViewInjection?
    
    init(view: IMGeneralMessageViewInjection) {
        self.view = view
    }
    
}

extension IMGeneralMessagePresenter: IMGeneralMessagePresenterDelegate {
    
    func viewDidLoad() {
    }
    
}
