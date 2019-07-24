//
//  BLECollectionPickerTableViewController.swift
//  BaleMediaPicker
//

import Foundation
import Photos
protocol BLECollectionPickerDelegate {
    func collectionPickerDidSelect(_ collection: CollectionModel)
}
class BLECollectionPickerViewController: UIViewController {
    var delegate: BLECollectionPickerDelegate?
    var albums:[CollectionModel] = [CollectionModel]()

    @IBOutlet weak var vwTableContainer: UIView!
    @IBAction func viewDidTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.reloadData()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vwTableContainer.layer.cornerRadius = 15
        vwTableContainer.layer.borderWidth = 2
        vwTableContainer.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        vwTableContainer.layer.masksToBounds = true
    }

    //MARK: grab collections
    func loadCollectionsFromGallery() {
        
        let options = PHFetchOptions()
        options.sortDescriptors=[NSSortDescriptor(key:"localizedTitle", ascending: true)]
        let userAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: options)
        let smartAlbums = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.any, options: options)
        print("Bale Media Picker: collection founds: \(userAlbums.count)")
        [userAlbums,smartAlbums].forEach { (albumObj) in
            albumObj.enumerateObjects{ (object: AnyObject!, count: Int, stop: UnsafeMutablePointer) in
                if object is PHAssetCollection {
                    let obj:PHAssetCollection = object as! PHAssetCollection
                    print("Bale Media Picker: object(\((obj.localizedTitle ?? "noname")))")
                    
                    let mediaCount: Int = obj.mediaCount.0
                    if mediaCount > 0 , let asset = obj.mediaCount.1{
                            PHImageManager.default().requestImage(for:asset , targetSize: CGSize(width: 250, height: 250), contentMode: .aspectFit, options: nil) { (image, _) in
                                let newCollection = CollectionModel(title: (obj.localizedTitle ?? "no name"), count: mediaCount, collection:obj,image: image ?? UIImage.bundled("ic_personalSpace", bundle: Bundle(for: BLECollectionPickerViewController.self))!)
                                self.albums.append(newCollection)
                            }
                        }
                }
            }
        }
        self.table.reloadData()
    }

}
extension BLECollectionPickerViewController:UITableViewDataSource,UITableViewDelegate{
    //MARK: tableView delegates
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.table.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath) as! BLECollectionCell
        let album = self.albums[indexPath.row]
        cell.imgAlbum.image = album.image
        cell.lbTitle.text = album.title
        cell.lbDetail.text = "\(album.count)"
        cell.imgAlbum.contentMode = .scaleAspectFill
        cell.imgAlbum.layer.masksToBounds = true

        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = self.albums[indexPath.row]
        print("Bale Media Picker: selected row: \(album.title)")
        self.delegate?.collectionPickerDidSelect(album)
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}
extension BLECollectionPickerViewController : UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}


