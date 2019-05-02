//
//  CustomCell.swift
//  CollectionView-Header-Footer-Sample
//
//  Created by kawaharadai on 2019/05/02.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    @IBOutlet weak private var numberLabel: UILabel!

    override func prepareForReuse() {
        contentView.backgroundColor = .white
    }

    func setText(_ text: String?) {
        numberLabel.text = text
    }

    func setBackgroundColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }
    
}
