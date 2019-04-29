//
//  ViewController.swift
//  BaleMediaPicker
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
