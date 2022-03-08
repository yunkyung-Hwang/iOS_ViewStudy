//
//  CustomCameraVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/03/08.
//

import UIKit
import AVFoundation
import Photos
import RxSwift
import RxCocoa
import PhotosUI

class CustomCameraVC: UIViewController {
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var galleryPreviewView: UIImageView!
    @IBOutlet weak var captureButton: UIButton!
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setupCameraView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    @IBAction func didTakePhoto(_ sender: Any) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        stillImageOutput.capturePhoto(with: settings, delegate: self)
    }
}

extension CustomCameraVC {
    func setUpView() {
        view.backgroundColor = .black
        
        captureButton.layer.cornerRadius = captureButton.frame.width/2
        captureButton.layer.borderColor = UIColor.white.cgColor
        captureButton.layer.borderWidth = 8
        
        galleryPreviewView.contentMode = .scaleAspectFill
        galleryPreviewView.backgroundColor = .darkGray
        galleryPreviewView.layer.cornerRadius = 5
        didTapGalleryPreviewView()
    }
    
    func setupCameraView() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: backCamera)
            stillImageOutput = AVCapturePhotoOutput()
            
            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print(error.localizedDescription)
        }
    }
    
    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        videoPreviewLayer.connection?.videoOrientation = .portrait
        cameraView.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            self.captureSession.startRunning()
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.cameraView.bounds
            }
        }
    }
    
    func saveImage() {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else { return }
            
            DispatchQueue.main.async {
                guard let image = self.galleryPreviewView.image else {
                    return
                }
                
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }, completionHandler: nil)
            }
        }
    }
    
    func didTapGalleryPreviewView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        galleryPreviewView.addGestureRecognizer(tapGesture)
        galleryPreviewView.isUserInteractionEnabled = true
    }
    
    @objc func openGallery() {
        // 'photoLibrary' will be deprecated in a future version of iOS: Will be removed in a future release, use PHPicker.
//        let gallery = UIImagePickerController()
//        gallery.sourceType = .photoLibrary
//        present(gallery, animated: true, completion: nil)
        
        var config = PHPickerConfiguration()
        config.selectionLimit = 3
        config.filter = PHPickerFilter.images

        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = self
        self.present(pickerViewController, animated: true, completion: nil)
    }
}

extension CustomCameraVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation() else { return }
        
        let image = UIImage(data: imageData)
        galleryPreviewView.image = image
        
        DispatchQueue.main.async {
            self.saveImage()
        }
    }
}

extension CustomCameraVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
       picker.dismiss(animated: true, completion: nil)
       
       for result in results {
          result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
             if let image = object as? UIImage {
                DispatchQueue.main.async {
                   print("Selected image: \(image)")
                }
             }
          })
       }
    }
}
