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
        
        return dateToStringFormatter.string(from: date)
    }
    
    func formatStringToDate() -> Date {
        let stringToDateFormatter = DateFormatter()
        stringToDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        stringToDateFormatter.locale = Locale(identifier: "ko_KR")
        return stringToDateFormatter.date(from: self) ?? Date()
    }
    
    func hasSpecialCharacters() -> Bool {
        if let regex = try? NSRegularExpression(pattern: "[0-9a-zA-Zㄱ-ㅎㅏ-ㅣ가-힣\\s]", options: .caseInsensitive) {
            let numOfString = regex.numberOfMatches(in: self, options: [], range: NSMakeRange(0, self.count))
            if numOfString == self.count {
                return false
            } else {
                return true
            }
        }
        return false
    }
    
    func utf8Encode() -> Data? {
        return data(using: .utf8)
    }
}
