//
//  BLEAssetCell.swift
//  BaleMediaPicker
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
