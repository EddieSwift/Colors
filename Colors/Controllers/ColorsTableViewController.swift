//
//  ColorsTableViewController.swift
//  Colors
//
//  Created by Eduard Galchenko on 7/13/19.
//  Copyright © 2019 Eduard Galchenko. All rights reserved.
//

import UIKit

struct Color {
    var colorName: String
    var colorCode: UIColor
}

var selectedCellIndexPath: IndexPath?
let selectedCellHeight: CGFloat = 240.0
let unselectedCellHeight: CGFloat = 60.0

final class ColorsTableViewController: UITableViewController, XMLParserDelegate {
    
    var colors: [Color] = []
    var elementName: String = String()
    var colorName = String()
    var colorCode = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.url(forResource: "Colors", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> ColorTableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ColorTableViewCell", owner: self, options: nil)?.first as! ColorTableViewCell
        
        let color = colors[indexPath.row]
        cell.configureWith(color: color)
        
        // select/deselect the cell
        if cell.isSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
            cell.configureWithSelect(color: color)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
            cell.configureWithDeselect(color: color)
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ColorTableViewCell
        let color = colors[indexPath.row]
        
        if selectedCellIndexPath != nil && selectedCellIndexPath == indexPath {
            selectedCellIndexPath = nil
        } else {
            selectedCellIndexPath = indexPath
        }
        
        tableView.beginUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
        
        // Checking if selected or deselected row
        if selectedCellIndexPath == nil {
            cell.configureWithDeselect(color: color)
        } else {
            cell.configureWithSelect(color: color)
        }
        
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ColorTableViewCell
        let color = colors[indexPath.row]
        cell.configureWithDeselect(color: color)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if selectedCellIndexPath == indexPath {
            return selectedCellHeight
        }
        
        return unselectedCellHeight
    }
    
    // MARK: XML Parser Methods
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "color" {
            
            var tempColor: Color = Color(colorName: "", colorCode: UIColor())
            
            if let name = attributeDict["name"] {
                tempColor.colorName = name
            }
            
            if let code = attributeDict["color"] {
                tempColor.colorCode = hexStringToUIColor(hex: code)
            }
            colors.append(tempColor)
        }
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
            alpha: CGFloat(1.0))
    }
    
}
