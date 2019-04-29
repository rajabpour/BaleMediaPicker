//
//  CollectionModel.swift
//  BaleMediaPicker
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
