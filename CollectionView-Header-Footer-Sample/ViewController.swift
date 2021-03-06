//
//  ViewController.swift
//  CollectionView-Header-Footer-Sample
//
//  Created by kawaharadai on 2019/05/02.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let cellCount = 20
    private var numbers = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        numbers = (0 ..< cellCount).map { $0 }
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: String(describing: CustomHeaderView.self), bundle: .main),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: String(describing: CustomHeaderView.self))
        collectionView.register(UINib(nibName: String(describing: CustomFooterView.self), bundle: .main),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: String(describing: CustomFooterView.self))
        if let customLayout = collectionView.collectionViewLayout as? CustomLayout {
            customLayout.delegate = self
        }
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCell
        cell.setText("\(numbers[indexPath.item])")
        if indexPath.item % 2 == 0 {
            cell.setBackgroundColor(.lightGray)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: String(describing: CustomHeaderView.self),
                                                                   for: indexPath) as? CustomHeaderView ?? UICollectionReusableView()
        case UICollectionView.elementKindSectionFooter:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                   withReuseIdentifier: String(describing: CustomFooterView.self),
                                                                   for: indexPath) as? CustomFooterView ?? UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }
}

extension ViewController: CustomLayoutDelegate {
    func headerViewHeight(_ indexPath: IndexPath) -> CGFloat {
        // section分けも可能
        return view.frame.size.height * 0.1
    }
    func footerViewHeight(_ indexPath: IndexPath) -> CGFloat {
        // section分けも可能
        return view.frame.size.height * 0.1
    }
}
