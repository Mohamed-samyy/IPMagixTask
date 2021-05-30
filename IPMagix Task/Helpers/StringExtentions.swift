//
//  StringExtentions.swift
//  IPMagix Task
//
//  Created by Mohamed Samy on 5/28/21.
//

import UIKit

extension String {
var localized: String {
    return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func encodeUrl() -> String
    {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    func decodeUrl() -> String
    {
        return self.removingPercentEncoding ?? ""
    }
}

