//
//  DevicePhotoCollectionView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/10.
//

//  참고: https://medium.com/@miraskarazhigitov/swiftly-over-the-photokit-f8d36a2df405
//  참고2: https://github.com/chublix/CustomImagePicker-Example/blob/master/CustomImagePicker/ImagePickerVC.swift

import UIKit
import Photos
import PhotoCropper

class DevicePhotoCV: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private var preview = PhotoCropperView()
    
    var devicePhotos: PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    var albumList = [PHAssetCollection]()
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        devicePhotos = PHAsset.fetchAssets(with: .ascendingOptions)
        setImageView([0,0])
        getAlbums()
        
        view.addSubview(preview)
        layoutPreview()
        preview.scrollView.alwaysBounceVertical = true
        preview.scrollView.alwaysBounceHorizontal = true
    }
    
    private func layoutPreview() {
        preview.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(preview.snp.width)
            $0.bottom.equalTo(collectionView.snp.top).offset(-12)
        }
    }
    
    func fetchAssets(with album: PHAssetCollection) {
        devicePhotos = PHAsset.fetchAssets(in: album, options: .ascendingOptions)
    }
    
    func setImageView(_ indexPath: IndexPath) {
        let width = devicePhotos.object(at: indexPath.row).pixelWidth
        let height = devicePhotos.object(at: indexPath.row).pixelHeight
        
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        
        PHImageManager.default().requestImage(for: devicePhotos.object(at: indexPath.row),
                                                 targetSize: CGSize(width: width,
                                                                    height: height),
                                                 contentMode: .aspectFit, options: options) { (image, _) in
            if image != nil {
                self.preview.imageView.image = image
                self.preview.updateZoomScale()
            } else {
                print("error")
            }
        }
    }
    
    func getAlbums() {
        let options:PHFetchOptions = PHFetchOptions()
        let getAlbums : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
        let getSmartAlbums: PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: options)
        // 앨범 정보
        // smartAlbum
        for i in 0 ..< getSmartAlbums.count{
            let collection:PHAssetCollection = getSmartAlbums[i]
            let assetsFetchResult: PHFetchResult = PHAsset.fetchAssets(in: collection, options: nil)
            print(collection.localizedTitle ?? "", assetsFetchResult.count)
            albumList.append(getSmartAlbums[i])
        }
        // 내가 생성한 앨범
        for i in 0 ..< getAlbums.count{
            let collection:PHAssetCollection = getAlbums[i]
            print(collection.localizedTitle ?? "", collection.estimatedAssetCount)
            albumList.append(getAlbums[i])
        }
        fetchAssets(with: albumList[0])
        print(devicePhotos.count)
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
        
        cell.id = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: cell.frame.size, contentMode: .aspectFill, options: nil) { (image, _) in
            cell.backgroundView = UIImageView(image: image)
        }
        
        return cell
    }
    
}

//MARK: UICollectionViewDelegate
extension DevicePhotoCV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        setImageView(indexPath)
        print(indexPath)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension DevicePhotoCV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3.2,
                      height: view.frame.width/3.2)
    }
}

extension PHFetchOptions {
    static var ascendingOptions: PHFetchOptions = {
        let option = PHFetchOptions()
        option.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return option
    }()
}
