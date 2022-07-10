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
