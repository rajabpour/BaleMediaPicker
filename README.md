# BaleMediaPicker

[![Version](https://img.shields.io/cocoapods/v/BaleMediaPicker.svg?style=flat)](https://cocoapods.org/pods/BaleMediaPicker)
[![License](https://img.shields.io/cocoapods/l/BaleMediaPicker.svg?style=flat)](https://cocoapods.org/pods/BaleMediaPicker/LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/BaleMediaPicker.svg?style=flat)](https://cocoapods.org/pods/BaleMediaPicker)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BaleMediaPicker is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BaleMediaPicker'
```

## How to use

```ruby
import BaleMediaPicker
import Photos

//call mediaPicker
        let pickerView = BaleMediaPicker(self) //self: your viewController
        pickerView.show()
```

```swift
//get selected assets by implementing BaleMediaPickerDelegate
extension ViewController :BaleMediaPickerDelegate{
    func baleMediaPicker(_ assets: [PHAsset]) {
        print(assets)
    }
}
```

## Authors

masoudrajabpour@gmail.com, mmtarighat@gmail.com

## License

BaleMediaPicker is available under the GPL-3.0 license. See the LICENSE file for more info.

