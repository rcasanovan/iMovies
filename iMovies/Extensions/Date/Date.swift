//
//  Date.swift
//  iMovies
//
//  Created by Ricardo Casanova on 05/09/2018.
//  Copyright © 2018 Careem. All rights reserved.
//

import Foundation

extension Date {
    
    public static func getMMMddyyyyFormatWithStringDate(_ stringDate: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        
        guard let dateObj = dateFormatter.date(from: stringDate) else {
            return nil
        }
        
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: dateObj)
    }
    
}
