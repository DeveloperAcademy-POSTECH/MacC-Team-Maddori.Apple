//
//  ImageCacheManager.swift
//  Maddori.Apple
//
//  Created by 이성민 on 2023/03/15.
//

import Foundation
import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
