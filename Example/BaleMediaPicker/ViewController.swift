//
//  ViewController.swift
//  BaleMediaPicker
//
//  Created by masoudrajabpour@gmail.com on 04/27/2019.
//  Copyright (c) 2019 masoudrajabpour@gmail.com. All rights reserved.
//

import UIKit
import BaleMediaPicker
import Photos
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func actionDidTap(_ sender: Any) {
        present()
    }
    func present(){
        let pickerView = BaleMediaPicker(self)
        pickerView.delegate = self
        pickerView.show()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ViewController :BaleMediaPickerDelegate{
    func baleMediaPicker(_ assets: [PHAsset]) {
        print(assets)
    }
    
    
}
