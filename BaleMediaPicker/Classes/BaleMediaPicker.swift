//
//  BaleMediaPickerViewController.swift
//  BaleMediaPicker
//

import UIKit
import Photos

public class BaleMediaPicker {
    private let previusVC : UIViewController!
    public var delegate : BaleMediaPickerDelegate?
    public init(_ vc:UIViewController ) {
        previusVC = vc
        delegate = previusVC as? BaleMediaPickerDelegate
    }
    private func presentPicker() {
        
        let storyboard = UIStoryboard(name: "BaleMediaPicker", bundle: Bundle(for: BaleMediaPicker.self))
        let picker =  storyboard.instantiateViewController(withIdentifier:"BaleMediaPicker") as! BLEImagePickerViewController
        picker.modalPresentationStyle = .popover
        picker.delegate = delegate
//        previusVC.view.addSubview(picker.view)
//        print("")
      previusVC.present(picker, animated: true, completion: nil)
        
    }
    public func show(){
        // Get the current authorization state.
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            presentPicker()
        }else if (status == PHAuthorizationStatus.denied) {
            // Access has been denied.
        }else if (status == PHAuthorizationStatus.notDetermined) {
            
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    self.presentPicker()
                }
                    
                else {
                    
                }
            })
        }else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
    }
}
