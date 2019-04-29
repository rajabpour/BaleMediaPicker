//
//  BLEVideoIndicatorView.swift
//  BaleMediaPicker
//

import Foundation
class BLEVideoIndicatorView: UIView {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var videoIcon: BLEVideoIconView!
    @IBOutlet weak var slomoIcon: BLESlomoIconView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Add gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        
        layer.insertSublayer(gradientLayer, at: 0)
    }

}
