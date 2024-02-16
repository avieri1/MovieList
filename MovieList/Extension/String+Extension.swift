//
//  String+Extension.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
    
    func convertToDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSZ"
        if let dt = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MM-dd-yy"
            let formatedStringDate = dateFormatter.string(from: dt)
            return formatedStringDate
        }
        
        return "01-01-01"
    }
    var htmlToAttributedString: NSAttributedString? {
        return Data(utf8).htmlToAttributedString
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
}
