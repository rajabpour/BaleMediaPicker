//
//  BLEAssetCell.swift
//  BaleMediaPicker
//
//  Created by Bale on 1/25/1398 AP.
//  Copyright © 1398 bale. All rights reserved.
//

import Foundation
class BLEAssetCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var videoIndicatorView: BLEVideoIndicatorView!
    var showsOverlayViewWhenSelected = true

    @IBOutlet private weak var overlayView: UIView!
    
    func setSelected(_ selected: Bool) {
        super.isSelected = selected
        // Show/hide overlay view
        overlayView.isHidden = !(selected)
        print("isHidden","\(overlayView.isHidden)")
        self.bringSubview(toFront: overlayView)
    }

}
