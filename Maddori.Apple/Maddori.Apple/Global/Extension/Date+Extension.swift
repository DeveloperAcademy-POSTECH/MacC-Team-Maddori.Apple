//
//  Date+Extension.swift
//  Maddori.Apple
//
//  Created by 김유나 on 2022/10/24.
//

import UIKit

extension Date {
    var dateToMonthDayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        return formatter.string(from: self)
    }
    
    var dateToYearMonthDayWeekString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "Y. M. d. (E)"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: self)
    }
}
