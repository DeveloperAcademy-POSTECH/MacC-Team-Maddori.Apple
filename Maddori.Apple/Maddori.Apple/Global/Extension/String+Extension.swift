//
//  String+Extension.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2022/11/17.
//

import Foundation

extension String {
    func formatDateString(to format: String) -> String {
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date: Date = stringToDateFormatter.date(from: self) else { return "" }
        let dateToStringFormatter = DateFormatter()
        dateToStringFormatter.locale = Locale(identifier:"ko_KR")
        dateToStringFormatter.dateFormat = format
        
        var returnDateString = dateToStringFormatter.string(from: date)
        if returnDateString.contains(" 0분") {
            returnDateString = dateToStringFormatter.string(from: date).replacingOccurrences(of: " 0분", with: "")
        }
        
        return returnDateString
    }
}
