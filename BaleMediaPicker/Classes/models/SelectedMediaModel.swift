//
//  SelectedMediaModel.swift
//  BaleMediaPicker
//
//  Created by Bale on 1/27/1398 AP.
//  Copyright © 1398 bale. All rights reserved.
//

import Foundation
import Photos
open class SelectedMediaModel {
    init(_ asset : PHAsset, indexPath : IndexPath, collection : CollectionModel) {
        self.asset = asset
        self.indexPath = indexPath
        self.collection = collection
    }
    open var asset : PHAsset
    open var indexPath : IndexPath = []
    open var collection : CollectionModel = CollectionModel(title: "", count: 0, collection: PHAssetCollection(), image: UIImage.bundled("ic_personalSpace", bundle: Bundle(for: SelectedMediaModel.self))!)
}
