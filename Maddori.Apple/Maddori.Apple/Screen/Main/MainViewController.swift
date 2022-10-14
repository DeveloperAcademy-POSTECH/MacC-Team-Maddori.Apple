//
//  MainViewController.swift
//  Maddori.Apple
//
//  Created by Mingwan Choi on 2022/10/14.
//

import UIKit

final class MainViewController: BaseViewController {
    private let testLabel: UILabel = {
        let label = UILabel(frame: .init(origin: .init(x: 100, y: 100), size: .init(width: 100, height: 100)))
        label.text = "Chemi"
        label.font = .font(.thin, ofSize: 20)
        return label
    }()
    override func viewDidLoad() {
        view.backgroundColor = .backgrounWhite
        print(UIFont.fontNames(forFamilyName: "Apple SD Gothic Neo"))
        view.addSubview(testLabel)
//        print(UIFont.familyNames)
    }
}
