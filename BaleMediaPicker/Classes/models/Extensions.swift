//
//  Extensions.swift
//  BaleMediaPicker
//
//  Created by Bale on 1/25/1398 AP.
//  Copyright © 1398 bale. All rights reserved.
//

import Foundation
import Photos

let frameworkBundle = Bundle(identifier: "ai.bale.BaleMediaPicker")!
public extension Bundle {
    static var framework: Bundle {
        get {
            return frameworkBundle
        }
    }
}
public extension UIImage {
    class func bundled(_ named: String) -> UIImage? {
        
        if let appImage = UIImage(named: named) {
            return appImage
        }
        return UIImage(named: named, in: Bundle.framework, compatibleWith: UITraitCollection(displayScale: UIScreen.main.scale))
    }
}
extension PHAssetCollection {
    
    var mediaCount: (Int,PHAsset?) {
        let fetchOptions = PHFetchOptions()
        let result = PHAsset.fetchAssets(in: self, options: fetchOptions)
        let asset = result.lastObject
        return (result.count , asset)
    }
}
extension String {
    func replacePattern(pattern: String, replaceWith: String = "") -> String {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            let range = NSMakeRange(0, self.count)
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: replaceWith)
        } catch {
            return self
        }
    }
}
