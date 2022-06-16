//
//  Dailyst.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/05/09.
//

import UIKit
import SnapKit
import Then
import Photos
import Alamofire

class Dailyst: UIViewController {
    private var playerBaseImage = UIImageView()
        .then {
            $0.image = UIImage(named: "playerBase")
            $0.layer.cornerRadius = 60
            $0.layer.shadowColor = UIColor.black.cgColor
            $0.layer.shadowOpacity = 0.3
            $0.layer.shadowOffset = CGSize(width: -7, height: 5)
            $0.layer.shadowRadius = 5
            $0.layer.masksToBounds = false
        }
    
    private var playerCD = UIImageView()
        .then {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = (UIScreen.main.bounds.width - 70 - 114) / 2
        }
    
    private let playerCenterImage = UIImageView()
        .then {
            $0.image = UIImage(named: "playerCenter")
        }
    
    private var changeThumbnailBtn = UIButton()
        .then {
            $0.backgroundColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1)
            $0.titleLabel?.textColor = .white
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            $0.setTitle("커버 이미지 변경하기 ", for: .normal)
            $0.setImage(UIImage(named: "Edit"), for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
            $0.layer.cornerRadius = 12
        }
    
    private var emotionStackView = UIStackView()
        .then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 19
        }
    
    private var urlSearchTextField = UITextView()
        .then {
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.textContainer.lineFragmentPadding = 0
            $0.isScrollEnabled = false
            $0.setTextViewPlaceholder("URL")
            $0.alignTextVerticallyInContainer()
        }
    
    private var searchBtn = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
            $0.tintColor = .black
        }
    
    private var seperator = UIView()
        .then {
            $0.backgroundColor = .lightGray
        }
    
    private var postTitle = UITextField()
        .then {
            $0.font = UIFont.systemFont(ofSize: 20)
            $0.placeholder = "제목"
        }
    
    private var postContent = UITextView()
        .then {
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.textContainer.lineFragmentPadding = 0
            $0.setTextViewPlaceholder("오늘은 어떤 영상을 보셨나요?")
        }
    
    let naviBar = NavigationBar()
    let postContentPlaceholder = "오늘은 어떤 영상을 보셨나요?"
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNaviBar()
        configureLayout()
        configureContentView()
        configureEmotionStackView()
        configurePlayer()
        configureURL()
        didTapSearchView()
    }
}

// MARK: - Configure
extension Dailyst {
    private func configureNaviBar() {
        naviBar.configureNaviBar(targetVC: self, title: "게시글 작성")
        naviBar.configureBackBtn(targetVC: self, action: #selector(dismissVC), naviType: .present)
        naviBar.configureRightBarBtn(targetVC: self, action: #selector(dismissVC), title: "저장")
    }
    
    private func configureContentView() {
        view.backgroundColor = .white
        postContent.delegate = self
        urlSearchTextField.delegate = self
    }
    
    private func configureEmotionStackView() {
        for emotion in EmotionType.allCases {
            let emotionBaseView = UIView()
            let emotionImage = UIImageView(image: emotion.emotionImage)
            let emotionTitle = UILabel()
            emotionImage.image?.withRenderingMode(.alwaysTemplate)
            emotionTitle.text = "\(emotion.emotionTitle)"
            emotionTitle.textColor = .lightGray
            emotionTitle.font = UIFont.systemFont(ofSize: 13)
            emotionTitle.textAlignment = .center
            emotionBaseView.addSubview(emotionImage)
            emotionBaseView.addSubview(emotionTitle)
            emotionImage.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(emotionImage.snp.width)
            }
            emotionTitle.snp.makeConstraints {
                $0.top.equalTo(emotionImage.snp.bottom).offset(10)
                $0.leading.trailing.bottom.equalToSuperview()
            }
            emotionStackView.addArrangedSubview(emotionBaseView)
        }
    }
    
    private func configurePlayer() {
        changeThumbnailBtn.addTarget(self, action: #selector(showGallery), for: .touchUpInside)
    }
    
    @objc func showGallery(){
        print("asdf")
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            // 갤러리 권한 존재, 갤러리로 전환
            openGallery()
        case .notDetermined:
            // 갤러리 권한 요청
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in }
        default:
            // 갤러리 권한 없음, 설정 화면으로 이동
            let accessConfirmVC = UIAlertController(title: "권한 필요", message: "갤러리 접근 권한이 없습니다. 설정 화면에서 설정해주세요.", preferredStyle: .alert)
            let goSettings = UIAlertAction(title: "설정으로 이동", style: .default) { (action) in
                print("go settings")
                
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            accessConfirmVC.addAction(goSettings)
            accessConfirmVC.addAction(cancel)
            self.present(accessConfirmVC, animated: true, completion: nil)
        }
    }
    
    // Gallery Open
    func openGallery() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func configureURL() {
        
    }
    
    private func configureLayout() {
        view.addSubview(playerBaseImage)
        playerBaseImage.addSubview(playerCD)
        playerCD.addSubview(playerCenterImage)
        view.addSubview(changeThumbnailBtn)
        view.addSubview(emotionStackView)
        view.addSubview(urlSearchTextField)
        view.addSubview(searchBtn)
        view.addSubview(seperator)
        view.addSubview(postTitle)
        view.addSubview(postContent)
        
        playerBaseImage.snp.makeConstraints {
            $0.top.equalTo(naviBar.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(57)
            $0.trailing.equalToSuperview().offset(-57)
            $0.height.equalTo(playerBaseImage.snp.width).multipliedBy(287.0/260.0)
        }
        
        playerCD.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(35)
            $0.trailing.equalToSuperview().offset(-35)
            $0.bottom.equalToSuperview().offset(-62)
        }
        
        playerCenterImage.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalToSuperview().multipliedBy(42.0/190.0)
        }
        
        changeThumbnailBtn.snp.makeConstraints {
            $0.top.equalTo(playerCD.snp.bottom).offset(23)
            $0.bottom.equalTo(playerBaseImage.snp.bottom).offset(-15)
            $0.leading.equalTo(playerBaseImage.snp.leading).offset(68)
            $0.trailing.equalTo(playerBaseImage.snp.trailing).offset(-68)
        }
        
        emotionStackView.snp.makeConstraints {
            $0.top.equalTo(playerBaseImage.snp.bottom).offset(29)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
            $0.height.equalTo(76)
        }
        
        urlSearchTextField.snp.makeConstraints {
//            $0.top.equalTo(emotionStackView.snp.bottom)
            $0.top.equalTo(emotionStackView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
//            $0.height.equalTo(59)
            $0.height.equalTo(40)
        }
        
        searchBtn.snp.makeConstraints {
            $0.centerY.equalTo(urlSearchTextField.snp.centerY)
            $0.trailing.equalToSuperview().offset(-30)
            $0.width.height.equalTo(24)
        }
        
        seperator.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(urlSearchTextField.snp.bottom)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        postTitle.snp.makeConstraints {
            $0.top.equalTo(urlSearchTextField.snp.bottom).offset(25)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(20)
        }
        
        postContent.snp.makeConstraints {
            $0.top.equalTo(postTitle.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.height.equalTo(80)
        }
    }
    
    private func didTapSearchView() {
        searchBtn.addTarget(self, action: #selector(getURLMetaData), for: .touchUpInside)
    }
    
    @objc func searchURL() {
        let url = "http://www.youtube.com/oembed?url=\(urlSearchTextField.text ?? "")&format=json"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                dump(json)
            }
    }
    
    @objc func searchYoutube() {
        var optionParams: Parameters {
            return [
                "q": String(describing: urlSearchTextField.text),
                "part": "snippet",
                "key": "API Key",
                "type": "video",
                "maxResults": 3,
                "regionCode": "KR"
            ]
        }
        
        let url = "https://www.googleapis.com/youtube/v3/search?"
        AF.request(url,
                   method: .get,
                   parameters: optionParams,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                dump(json)
        }
    }
    
    @objc func getURLMetaData() {
//        let url = NSURL(string: String(describing: urlSearchTextField.text))
        let url = NSURL(string: "https://theawesome.tistory.com/4")

        let session = URLSession.shared

        let task = session.dataTask(with: url! as URL, completionHandler: { data, response, error in
            if error == nil {
                let urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                print(urlContent ?? "No contents foind!!!")
                dump(urlContent)
            } else {
                print("error")
            }
        })

        task.resume()
    }
}

extension Dailyst: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .lightGray else { return }
        textView.textColor = .label
        textView.text = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.setTextViewPlaceholder(postContentPlaceholder)
        }
    }
}

//MARK: UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension Dailyst: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImg: UIImage? = nil
                
        if let possibleImage = info[.editedImage] as? UIImage {
            selectedImg = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            selectedImg = possibleImage
        }
        
        playerCD.image = selectedImg
        playerCD.contentMode = .scaleAspectFill
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}


extension UITextView {
    func setTextViewPlaceholder(_ placeholder: String) {
        if text == "" {
            text = placeholder
            textColor = .lightGray
        }
    }
    
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.size.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        self.contentInset.top = topCorrect
    }
}
