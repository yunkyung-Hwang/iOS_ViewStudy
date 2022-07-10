//
//  MapKitView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/07/10.
//

import UIKit
import MapKit
import Then
import SnapKit

class MapkitView: UIViewController {
    private var mapView = MKMapView()
        .then {
            $0.showsUserLocation = true
        }
    
    private var locationManager = CLLocationManager()
        .then {
            // 정확도 설정
            $0.desiredAccuracy = kCLLocationAccuracyBest
            // 위치 데이터를 추적하기 위한 사용자 승인 요구
            // iOS 13에서는 팝업 허용에서 명시적인 '항상 허용' 사용 불가
            // 1) 앱이 백그라운드 상태일때,
            // 2) 앱에서 위치 정보를 백그라운드 상태에서 사용하겠다고 정의해 놓은 경우 가능!
            $0.allowsBackgroundLocationUpdates = true
            // 위치정보 업데이트 시작
            $0.requestAlwaysAuthorization()
            // 위치 보기 설정
            $0.startUpdatingLocation()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
    }
}

// MARK: - Configure
extension MapkitView {
    private func configureView() {
        view.addSubview(mapView)
        locationManager.delegate = self
    }
}

// MARK: - layout
extension MapkitView {
    private func configureLayout() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension MapkitView: CLLocationManagerDelegate {
    /// 위도, 경도, 스팬(영역 폭)을 입력받아 지도에 표시
    func goLocation(latitudeValue: CLLocationDegrees,
                           longtudeValue: CLLocationDegrees,
                           delta span: Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longtudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        mapView.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    /// 특정 위도와 경도에 핀 설치하고 핀에 타이틀과 서브 타이틀의 문자열 표시
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longtudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        mapView.addAnnotation(annotation)
    }
    
    // 이동 시 처리 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        
        // 현재 위치로 이동
        _ = goLocation(latitudeValue: location.coordinate.latitude,
                       longtudeValue: location.coordinate.longitude,
                       delta: 0.01)
        locationManager.stopUpdatingLocation()
    }
}
