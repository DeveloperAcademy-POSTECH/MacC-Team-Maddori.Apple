//
//  UIImageView+Extension.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2023/03/06.
//

import Foundation
import UIKit

extension UIImageView {
    func load(from url: String) {
        
        let cacheKey = NSString(string: url)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageUrl = URL(string: url),
               let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        ImageCacheManager.shared.setObject(image, forKey: cacheKey)
                        self?.image = image
                    }
                }
            }
        }
    }
}
