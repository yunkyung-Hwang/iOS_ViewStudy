//
//  MapKitView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/07/10.
//

import UIKit
import MapKit
import CoreLocation
import Then
import SnapKit

class MapkitView: UIViewController {
    private var mapView = MKMapView()
        .then {
            $0.mapType = .standard
            $0.setUserTrackingMode(.followWithHeading, animated: true)
            $0.showsUserLocation = true
            $0.isZoomEnabled = true
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
            $0.activityType = .fitness
        }
    
    private var previousCoordinate: CLLocationCoordinate2D?
    private var track: [CLLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
    }
    
    /// 메모리 경고를 수신할 경우 뷰 컨트롤러로 전송
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - Configure
extension MapkitView {
    private func configureView() {
        view.addSubview(mapView)
        locationManager.delegate = self
        mapView.delegate = self
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
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        
        // 현재 위치로 이동
        _ = goLocation(latitudeValue: location.coordinate.latitude,
                       longtudeValue: location.coordinate.longitude,
                       delta: 0.01)
        
        track.append(locations[0])
        
        // 이동 경로 그리기
        if let previousCoordinate = previousCoordinate {
            var points: [CLLocationCoordinate2D] = []
            let point1 = CLLocationCoordinate2DMake(previousCoordinate.latitude, previousCoordinate.longitude)
            let point2: CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(latitude, longtitude)
            points.append(point1)
            points.append(point2)
            let lineDraw = MKPolyline(coordinates: points, count:points.count)
            // func mapView(...rendererFor overlay: MKOverlay...) -> MKOverlayRenderer 함수 호출
            mapView.addOverlay(lineDraw)
        }
        previousCoordinate = location.coordinate
    }
}

extension MapkitView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 10
            renderer.alpha = 1
            renderer.createPath()
            
            return renderer
        } else {
            print("영역을 그릴 수 없습니다")
            return MKOverlayRenderer()
        }
    }
}
