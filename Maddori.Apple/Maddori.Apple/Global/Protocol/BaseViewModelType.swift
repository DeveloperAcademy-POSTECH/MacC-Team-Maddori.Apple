//
//  BaseViewModelType.swift
//  Maddori.Apple
//
//  Created by 이성호 on 11/3/23.
//

import Foundation

protocol BaseViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(from input: Input) -> Output
}
