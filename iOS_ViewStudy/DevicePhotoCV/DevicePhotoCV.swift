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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var devicePhotos: PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
        fetchAssets()
    }
    
    func fetchAssets() {
        devicePhotos = PHAsset.fetchAssets(with: .ascendingOptions)
    }
    
//    // 사진첩에 접근 허용하고 바로 로드하도록
//    func requestAuthorization() {
//        PHPhotoLibrary.requestAuthorization { (status) in
//            switch status {
//            case .notDetermined:
//                PHPhotoLibrary.requestAuthorization() { status in
//                    if status == .authorized {
//                        DispatchQueue.main.async {
//                            self.fetchAssets()
//                            self.collectionView.reloadData()
//                        }
//                    }
//                }
//            case .authorized:
//                DispatchQueue.main.async {
//                    self.fetchAssets()
//                    self.collectionView.reloadData()
//                }
//            default:
//                break
//            }
//        }
//    }
}

//MARK: UICollectionViewDataSource
extension DevicePhotoCV: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return devicePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! DevicePhotoCVC
        
        let asset = devicePhotos.object(at: indexPath.item)
        
        cell.id = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: cell.frame.size, contentMode: .aspectFill, options: nil) { (image, _) in
            cell.backgroundView = UIImageView(image: image)
//            cell.imageView = UIImageView(image: image)
        }
        
        return cell
    }
    
}

//MARK: UICollectionViewDelegate
extension DevicePhotoCV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! DevicePhotoCVC
        
        print(cell.backgroundView?.largeContentImage?.imageWithoutBaseline())
        imageView.image = cell.backgroundView?.largeContentImage?.imageWithoutBaseline()
//        view.
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension DevicePhotoCV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3.2, height: view.frame.width/3.2)
    }
}

extension PHFetchOptions {
    static var ascendingOptions: PHFetchOptions = {
        let option = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return option
    }()
}
