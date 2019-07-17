//
//  ColorTableViewCell.swift
//  Colors
//
//  Created by Eduard Galchenko on 7/13/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

final class ColorTableViewCell: UITableViewCell {
    
    public static let identifier = "ColorTableViewCell"
    private static let nibName = "ColorTableViewCell"
    
    // MARK: Outlets
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var colorNameLabel: UILabel!
    
    public static func register(in tableView: UITableView) {
        let nib = UINib.init(nibName: nibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: identifier)
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
