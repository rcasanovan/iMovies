//
//  IMGeneralMessageProtocols.swift
//  iMovies
//
//  Created by Ricardo Casanova on 07/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

// View / Presenter
protocol IMGeneralMessageViewInjection : class {
    func load(title: String, message: String)
}

protocol IMGeneralMessagePresenterDelegate : class {
    func viewDidLoad()
}
