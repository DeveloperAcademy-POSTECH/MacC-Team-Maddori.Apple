//
//  UIViewController+Rx.swift
//  Maddori.Apple
//
//  Created by 이성민 on 11/9/23.
//

import UIKit

import RxCocoa
import RxSwift

public extension Reactive where Base: UIViewController {
    var viewDidLoad: Observable<Void> {
        return Observable.just(())
    }
    
    var viewWillAppear: Observable<Void> {
        return self.methodInvoked(#selector(Base.viewWillAppear)).map { _ in }
    }
    
    var viewDidAppear: Observable<Void> {
        return self.methodInvoked(#selector(Base.viewDidAppear)).map { _ in }
    }
    
    var viewWillDisappear: Observable<Void> {
        return self.methodInvoked(#selector(Base.viewWillDisappear)).map { _ in }
    }
    
    var viewDidDisappear: Observable<Void> {
        return self.methodInvoked(#selector(Base.viewDidDisappear)).map { _ in }
    }
}
