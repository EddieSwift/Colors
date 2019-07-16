//
//  ColorTableViewCell.swift
//  Colors
//
//  Created by Eduard Galchenko on 7/13/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

final class ColorTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var colorNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.backgroundColor = UIColor.darkGray
        cellView.layer.cornerRadius = 8.0
        cellView.clipsToBounds = true
    }
    
    func configureWith(color: Color) {
        
        self.colorNameLabel.text = color.colorName
        self.colorNameLabel.textColor = color.colorCode
    }
    
    func configureWithSelect(color: Color) {
        
        self.colorNameLabel.textColor = UIColor.darkGray
        self.cellView.backgroundColor = color.colorCode
    }
    
    func configureWithDeselect(color: Color) {
        
        self.colorNameLabel.textColor = color.colorCode
        self.cellView.backgroundColor = UIColor.darkGray
    }
    
}
