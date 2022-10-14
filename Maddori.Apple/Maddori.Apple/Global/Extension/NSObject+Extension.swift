//
//  NSObject+Extension.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
