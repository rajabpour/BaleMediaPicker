//
//  CollectionModel.swift
//  BaleMediaPicker
//
//  Created by Bale on 1/27/1398 AP.
//  Copyright © 1398 bale. All rights reserved.
//

import Foundation
import Photos
open class CollectionModel {
    let image:UIImage
    let title:String
    let count:Int
    let collection:PHAssetCollection
    init(title:String, count:Int, collection:PHAssetCollection , image:UIImage) {
        self.title = title
        self.count = count
        self.collection = collection
        self.image = image
    }
}
