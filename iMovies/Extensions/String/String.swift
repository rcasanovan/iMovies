//
//  String.swift
//  iMovies
//
//  Created by Ricardo Casanova on 06/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

extension String {
    
    func isEmptyOrWhitespace() -> Bool {
        if self.isEmpty  { return true }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
    
    func condenseWhitespaces() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
    
}
