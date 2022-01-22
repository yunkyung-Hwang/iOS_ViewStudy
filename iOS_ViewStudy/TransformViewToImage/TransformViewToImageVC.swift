//
//  TransformViewToImage.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/22.
//  참고: https://ios-development.tistory.com/237
//  참고: https://ttuk-ttak.tistory.com/85

import UIKit
import Photos

class TransformViewToImageVC: UIViewController {

    @IBOutlet weak var baseView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func shareImage(_ sender: Any) {
        guard let image = baseView.transfromToImage() else {
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        vc.excludedActivityTypes = [.saveToCameraRoll]
        present(vc, animated: true)
    }
    @IBAction func saveImage(_ sender: Any) {
        guard let image = baseView.transfromToImage() else {
            return
        }
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else { return }
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }, completionHandler: nil)
        }
    }
}

extension UIView {
    func transfromToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer {
            UIGraphicsEndImageContext()
        }
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
        return nil
    }
}
