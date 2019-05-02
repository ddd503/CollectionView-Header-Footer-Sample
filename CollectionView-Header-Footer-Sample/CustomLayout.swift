//
//  CustomLayout.swift
//  CollectionView-Header-Footer-Sample
//
//  Created by kawaharadai on 2019/05/02.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class CustomLayout: UICollectionViewLayout {

    // MARK: - Propatis

    private let numberOfColumns = 3
    private let cellPadding = CGFloat(integerLiteral: 1)
    private var cachedAttributes = [UICollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    // MARK: - Life Cycle

    override func prepare() {
        resetAttributes()
        setupAttributes()
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.filter({ (layoutAttributes) -> Bool in
            rect.intersects(layoutAttributes.frame)
        })
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cachedAttributes[indexPath.item]
    }

    // MARK: - Private

    private func setupAttributes() {
        guard cachedAttributes.isEmpty, let collectionView = collectionView else { return }
        let cellLength = contentWidth / CGFloat(numberOfColumns)
        let cellXOffsets = (0 ..< numberOfColumns).map {
            CGFloat($0) * cellLength
        }
        gridAttributes(collectionView: collectionView, cellLength: cellLength, cellXOffsets: cellXOffsets)
    }

    private func resetAttributes() {
        cachedAttributes = []
        contentHeight = 0
        collectionView?.contentOffset.y = 0
    }

    private func addAttributes(cellFrame: CGRect, indexPath: IndexPath) {
        let itemFrame = cellFrame.insetBy(dx: cellPadding, dy: cellPadding)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        attributes.frame = itemFrame
        cachedAttributes.append(attributes)
        contentHeight = max(contentHeight, cellFrame.maxY)
    }

    private func gridAttributes(collectionView: UICollectionView, cellLength: CGFloat, cellXOffsets: [CGFloat]) {
        var cellYOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
        var currentColumnNumber = 0
        (0 ..< collectionView.numberOfItems(inSection: 0)).forEach {
            let indexPath = IndexPath(item: $0, section: 0)
            let cellFrame = CGRect(x: cellXOffsets[currentColumnNumber], y: cellYOffsets[currentColumnNumber], width: cellLength, height: cellLength)
            cellYOffsets[currentColumnNumber] = cellYOffsets[currentColumnNumber] + cellLength
            currentColumnNumber = currentColumnNumber < (numberOfColumns - 1) ? currentColumnNumber + 1 : 0
            addAttributes(cellFrame: cellFrame, indexPath: indexPath)
        }
    }

}
