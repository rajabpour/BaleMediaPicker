//
//  BLENavigateBarView.swift
//  BaleMediaPicker
//
//  Created by Bale on 1/26/1398 AP.
//  Copyright © 1398 bale. All rights reserved.
//

import Foundation
protocol BLENavigateBarViewDelegate {
    func headerViewDoneDidTap()
    func headerViewCancelDidTap()
    func headerViewCollectionDidChange(with selectedIndex: Int)
    func headerViewGalleryDidTap(_ sender:Any)
}
class BLENavigateBarView: UINavigationBar {
    var navigateDelegate : BLENavigateBarViewDelegate?
    
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet var btnDone: UIBarButtonItem!
    @IBOutlet var btnCancel: UIBarButtonItem!
    
    @IBAction func galleyDidTap(_ sender: Any) {
        self.navigateDelegate?.headerViewGalleryDidTap(sender)
    }
    @IBAction func btnDoneDidTap(_ sender: Any) {
        self.navigateDelegate?.headerViewDoneDidTap()
    }
    @IBAction func btnCancelDidTap(_ sender: Any) {
        self.navigateDelegate?.headerViewCancelDidTap()
    }    
    func setSelectedCount(with count: Int) {
        self.btnDone.title = self.btnDone.title?.replacePattern(pattern: "\\d{1,9999}", replaceWith: "\(count)")
        self.btnDone.isEnabled = count > 0
    }
    func setCollectionTitle(with title: String) {
        self.btnGallery.setAttributedTitle(NSAttributedString(string: title, attributes: [
            NSMutableAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 17),
            NSMutableAttributedString.Key.foregroundColor : UIColor.black
            ]), for: .normal)
        
    }
}
