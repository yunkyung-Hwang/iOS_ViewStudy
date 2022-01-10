//
//  DevicePhotoCollectionView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/10.
//

//  참고: https://medium.com/@miraskarazhigitov/swiftly-over-the-photokit-f8d36a2df405

import UIKit
import Photos

class DevicePhotoCV: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var devicePhotos: PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        devicePhotos = PHAsset.fetchAssets(with: nil)
        collectionView.reloadData()
    }
}

//MARK: UICollectionViewDataSource
extension DevicePhotoCV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devicePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! DevicePhotoCVC
        
        let asset = devicePhotos.object(at: indexPath.item)
        
        imageManager.requestImage(for: asset, targetSize: cell.frame.size, contentMode: .aspectFill, options: nil) { (image, _) in
            cell.backgroundView = UIImageView(image: image)
        }
        
        return cell
    }
    
}

//MARK: UICollectionViewDelegate
extension DevicePhotoCV: UICollectionViewDelegate {
    
}

//MARK: UICollectionViewDelegateFlowLayout
extension DevicePhotoCV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3.2, height: view.frame.width/3.2)
    }
}
