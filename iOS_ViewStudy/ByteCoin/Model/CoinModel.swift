//
//  CoinModel.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/26.
//

struct CoinModel {
    let rate: Double
    let asset_id_quote: String
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
