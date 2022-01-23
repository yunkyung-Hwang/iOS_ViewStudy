//
//  CollectionViewBasicVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/23.
//

import UIKit

class CollectionViewBasicVC: UIViewController {
    let data = ["a","b","c","d","e","f","g","h","i"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
extension CollectionViewBasicVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BasicCVC
        cell.title.text = data[indexPath.row]
        cell.title.textColor = .white
        
        return cell
    }
}

extension CollectionViewBasicVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width / 3.2
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
}
