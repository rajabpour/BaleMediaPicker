//
//  BLEVideoIconView.swift
//  BaleMediaPicker
//
//  Created by Bale on 1/25/1398 AP.
//  Copyright © 1398 bale. All rights reserved.
//

import Foundation

class BLEVideoIconView : UIView{
    @IBInspectable var iconColor: UIColor?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Set default values
        self.iconColor = UIColor.white
    }
    override func draw(_ rect: CGRect) {
        self.iconColor?.setFill()
        
        // Draw triangle
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        trianglePath.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        trianglePath.addLine(to: CGPoint(x: bounds.maxX - bounds.midY, y: bounds.midY))
        trianglePath.close()
        trianglePath.fill()
        
        // Draw rounded square
        let squarePath = UIBezierPath(roundedRect: CGRect(x: bounds.minX, y: bounds.minY, width: bounds.width - bounds.midY - 1.0, height: bounds.height), cornerRadius: 2.0)
        squarePath.fill()
    }
}
