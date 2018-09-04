//
//  IMSearchProtocols.swift
//  iMovies
//
//  Created by Ricardo Casanova on 04/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

// View / Presenter
protocol IMSearchViewInjection : class {
}

protocol IMSearchPresenterDelegate : class {
    func viewDidLoad()
}

// Presenter / Interactor

protocol IMSearchInteractorDelegate : class {
}
