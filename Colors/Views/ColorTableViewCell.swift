//
//  ColorTableViewCell.swift
//  Colors
//
//  Created by Eduard Galchenko on 7/13/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

class ColorTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellView.backgroundColor = UIColor.darkGray
        cellView.layer.cornerRadius = 8.0
        cellView.clipsToBounds = true
    }

    func configureWith(color: Color) {
        
        self.colorNameLabel.text = color.colorName
        self.colorNameLabel.textColor = hexStringToUIColor(hex: color.colorCode)
    }
    
    func configureWithSelect(color: Color) {
        
        self.colorNameLabel.textColor = UIColor.darkGray
        self.cellView.backgroundColor = hexStringToUIColor(hex: color.colorCode)
    }
    
    func configureWithDeselect(color: Color) {
        
        self.colorNameLabel.textColor = hexStringToUIColor(hex: color.colorCode)
        self.cellView.backgroundColor = UIColor.darkGray
    }
    
    // MARK: Convert HEX to RGB Color
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
