//
//  IMGeneralMessagePresenter.swift
//  iMovies
//
//  Created by Ricardo Casanova on 07/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

/**
 * Enum to manage all the possible messages types
 * For now I'm using only NoInternetConnection type but it's possible to extend this in the future
 */
enum IMGeneralMessageType {
    case NoInternetConnection
}

class IMGeneralMessagePresenter {
    
    private weak var view: IMGeneralMessageViewInjection?
    private let type: IMGeneralMessageType
    
    init(view: IMGeneralMessageViewInjection, type: IMGeneralMessageType) {
        self.view = view
        self.type = type
    }
    
}

extension IMGeneralMessagePresenter: IMGeneralMessagePresenterDelegate {
    
    /**
     * View did load
     */
    func viewDidLoad() {
        switch type {
        case .NoInternetConnection:
            view?.load(title: "Without connection to the network.", message: "iMovies needs to connect to the internet.\nCheck the connections and try again.")
            break
        }
    }
    
}
