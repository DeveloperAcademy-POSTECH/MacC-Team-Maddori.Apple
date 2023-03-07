//
//  UIImageView+Extension.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2023/03/06.
//

import UIKit

extension UIImageView {
    func load(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
