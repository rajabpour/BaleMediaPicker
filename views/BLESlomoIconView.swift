//
//  BLEVideoIconView.swift
//  BaleMediaPicker
//
//  Created by Bale on 1/25/1398 AP.
//  Copyright © 1398 bale. All rights reserved.
//

import Foundation

class BLESlomoIconView : UIView{
    @IBInspectable var iconColor: UIColor = UIColor.white
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set default values
        self.iconColor = UIColor.white
    }
    override func draw(_ rect: CGRect) {
        self.iconColor.setStroke()
        
        let width: CGFloat = 2.2
        let insetRect: CGRect = rect.insetBy(dx: width / 2, dy: width / 2)
        
        // Draw dashed circle
        let circlePath = UIBezierPath(ovalIn: insetRect)
        circlePath.lineWidth = width
        var ovalPattern : CGFloat = 0.75//[0.75, 0.75]
        circlePath.setLineDash(&ovalPattern, count: 2, phase: 0)
        circlePath.stroke()

    }
}
