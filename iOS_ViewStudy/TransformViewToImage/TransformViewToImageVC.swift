//
//  TransformViewToImage.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/22.
//  참고: https://ios-development.tistory.com/237

import UIKit

class TransformViewToImageVC: UIViewController {

    @IBOutlet weak var baseView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveViewToImage(_ sender: Any) {
        guard let image = baseView.transfromToImage() else {
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        vc.excludedActivityTypes = [.saveToCameraRoll]
        present(vc, animated: true)
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
