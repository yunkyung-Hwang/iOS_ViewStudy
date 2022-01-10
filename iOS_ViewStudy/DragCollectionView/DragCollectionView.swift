//
//  DragCollectionView.swift
//  iOS_ViewStudy
//
//  Created by 황윤경 on 2022/01/10.
//

import UIKit

class DragCollectionView: UIViewController {
    var data = ["a","b","c","d","e","f","g","h","i"]
    
    @IBOutlet weak var dragCV: UICollectionView!
    
    override func viewDidLoad() {
        dragCV.dataSource = self
        dragCV.delegate = self
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        
        gesture.minimumPressDuration = 0.0
        dragCV.addGestureRecognizer(gesture)
    }
    
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        guard let collectionView = dragCV else { return }

        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture .location(in: collectionView)) else { return }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}
//MARK: UICollectionViewDataSource
extension DragCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DragCollecionViewCell
        cell.backgroundColor = .systemIndigo
        cell.label.textColor = .white
        cell.label.text = data[indexPath.row]
        
        return cell
    }
}
//MARK: UICollectionViewDelegate
extension DragCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = data.remove(at: sourceIndexPath.row)
        data.insert(item, at: destinationIndexPath.row)
    }
}
//MARK: UICollectionViewDelegateFlowLayout
extension DragCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3.2, height: view.frame.width/3.2)
    }
}
