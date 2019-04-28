//
//  BaleMediaPicker.swift
//  BaleMediaPicker
//
//  Created by Bale on 1/25/1398 AP.
//  Copyright © 1398 bale. All rights reserved.
//

import Foundation
import Photos

public protocol BaleMediaPickerDelegate {
    func baleMediaPicker(_ assets : [PHAsset])
}
open class BLEImagePickerViewController: UIViewController {
    
    @IBOutlet weak var collection: UICollectionView!

    @IBOutlet weak var headerView: BLENavigateBarView!
    var albums:[CollectionModel] = [CollectionModel]()
    var delegate:BaleMediaPickerDelegate?
    fileprivate var assets = [PHAsset]()
    fileprivate var selectedAssets = [SelectedMediaModel]()
    fileprivate let imageManager=PHImageManager.default()
    fileprivate var selectedCollection : CollectionModel!

    fileprivate let minimumPreviewHeight: CGFloat = 150
    fileprivate var maximumPreviewHeight: CGFloat = 150
    
    fileprivate let backgroundQueue = DispatchQueue(label: "ai.bale.background", attributes: [])
    
    fileprivate lazy var requestOptions: PHImageRequestOptions = {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .fast
        
        return options
    }()
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        loadCollectionsFromGallery()
        loadMediasFromGallery()
        headerView.navigateDelegate = self
        headerView.setSelectedCount(with: self.selectedAssets.count)
        headerView.setCollectionTitle(with: self.selectedCollection?.title ?? "")
        if #available(iOS 10.0, *) {
            collection.prefetchDataSource = self
        } else {
            // Fallback on earlier versions
        }
    }
    
    //MARK: grab collections
    func loadCollectionsFromGallery() {
        
        let options = PHFetchOptions()
        options.sortDescriptors=[NSSortDescriptor(key:"localizedTitle", ascending: true)]
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: options)
        print("collection founds: \(userAlbums.count)")
        [userAlbums,smartAlbums].forEach { (albumObj) in
            albumObj.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
                if object is PHAssetCollection {
                    let obj:PHAssetCollection = object as! PHAssetCollection
                    print("object(\((obj.localizedTitle ?? "noname")))")
                    
                    let (mediaCount, mediaAsset) = obj.mediaCount
                    if obj.localizedTitle == "Camera Roll"{
                        print("CameraRoll founded")
                        self.selectedCollection = CollectionModel(title: (obj.localizedTitle ?? "no name"), count: 0, collection:obj, image: UIImage.bundled("ic_personalSpace")!)
                    }
                    if mediaCount > 0 , let asset = mediaAsset{
                        PHImageManager.default().requestImage(for:asset , targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { (image, _) in
                            let newCollection = CollectionModel(title: (obj.localizedTitle ?? "no name"), count: mediaCount, collection:obj,image: image ?? UIImage.bundled("ic_personalSpace")!)
                            self.albums.append(newCollection)
                        }
                    }
                }
            }
        }
    }


    //MARK: grab medias
    func loadMediasFromGallery(){
        assets = []
        guard self.selectedCollection != nil else {
            return
        }
        backgroundQueue.async {
            print("This is run on the background queue")
            
            let fetchOptions=PHFetchOptions()
            fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(in: self.selectedCollection.collection, options: fetchOptions)
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count{
                    let asset: PHAsset = fetchResult.object(at: i) as PHAsset
                    self.assets.append(asset)
                }
            } else {
                print("You got no media in collection(\(self.selectedCollection.title)).")
            }
            print("media count: \(self.assets.count)")
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                self.collection.reloadData()
            }
        }
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) / 60 // % 60
//      let hours = (interval / 3600)
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}
extension BLEImagePickerViewController: UICollectionViewDataSourcePrefetching{
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
    public func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension BLEImagePickerViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    ///MARK collection view delegate
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.assets.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCell", for: indexPath) as! BLEAssetCell
        let asset = self.assets[index]
        if self.selectedAssets.contains(where: { ($0.asset == asset)}){
            cell.setSelected(true)
            
        }else{
            cell.setSelected(false)
        }
        imageManager.requestImage(for: asset, targetSize: CGSize(width:minimumPreviewHeight, height: maximumPreviewHeight),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
            cell.imageView.image = image!
            cell.videoIndicatorView.timeLabel.text = self.stringFromTimeInterval(interval: asset.duration)
            cell.videoIndicatorView.isHidden = asset.duration <= 0
        })
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssetCell", for: indexPath) as! BLEAssetCell
        let asset = self.assets[indexPath.row]
        if self.selectedAssets.contains(where: { ( $0.asset == asset)}){
            cell.setSelected(false)
            let i :Int = self.selectedAssets.index{( $0.asset == asset)}!
            self.selectedAssets.remove(at: i)
        }else{
            cell.setSelected(true)
            self.selectedAssets.append(SelectedMediaModel(asset, indexPath: indexPath, collection: selectedCollection))
        }
        headerView.setSelectedCount(with: self.selectedAssets.count)
        collectionView.reloadItems(at: [indexPath])
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/4)-1, height: (UIScreen.main.bounds.width/4)-1)
    }
}

extension BLEImagePickerViewController : BLENavigateBarViewDelegate{
    func headerViewCollectionDidChange(with selectedIndex: Int) {
        self.collection.reloadData()
    }
    
    func headerViewCancelDidTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func headerViewDoneDidTap() {
        var arAssets = [PHAsset]()
        for asset in selectedAssets {
            arAssets.append(asset.asset)
        }
        delegate?.baleMediaPicker(arAssets)
        self.dismiss(animated: true, completion: nil)
    }
    
    func headerViewGalleryDidTap(_ sender : Any) {
        let storyboard = UIStoryboard(name: "BaleMediaPicker", bundle: Bundle.framework)
        let popupVC =  storyboard.instantiateViewController(withIdentifier:"BLECollectionPickerViewController") as! BLECollectionPickerViewController
        popupVC.delegate = self
        popupVC.albums = self.albums
        popupVC.modalPresentationStyle = .overCurrentContext
        popupVC.modalTransitionStyle = .crossDissolve
        self.present(popupVC, animated: true, completion: nil)
    }
}
extension BLEImagePickerViewController : BLECollectionPickerDelegate{
    func collectionPickerDidSelect(_ collection: CollectionModel) {
        print("selected collection: \(collection.title)")
        self.selectedCollection = collection
        self.headerView.setCollectionTitle(with: collection.title)
        self.loadMediasFromGallery()
    }
}

extension BLEImagePickerViewController: UIPopoverPresentationControllerDelegate{
    
}
