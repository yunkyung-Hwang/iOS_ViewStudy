//
//  CollectionViewBasicVC.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/23.
//  참고: https://baechukim.tistory.com/9

import UIKit

class CollectionViewBasicVC: UIViewController {
    let data = ["a","b","c","d","e","f","g","h","i"]
    
    @IBOutlet weak var collectionView: UICollectionView!

    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

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
        let width = collectionView.frame.width
        let itemsPerRow: CGFloat = 3
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = cellWidth
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
