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
    var colorCode: String
}

var selectedCellIndexPath: IndexPath?
var unselectedCellIndexPath: Bool?
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = Bundle.main.loadNibNamed("ColorTableViewCell", owner: self, options: nil)?.first as! ColorTableViewCell
        
        let color = colors[indexPath.row]
        cell.configureWith(color: color)
        
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
        tableView.endUpdates()
        
        if selectedCellIndexPath != nil {
            // This ensures, that the cell is fully visible once expanded
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
        
        // Checking if select, unselect and deselects row
        if unselectedCellIndexPath == nil {
            unselectedCellIndexPath = true
        }
        
        if unselectedCellIndexPath == true {
            unselectedCellIndexPath = false
        } else {
            unselectedCellIndexPath = true
        }
        
        if unselectedCellIndexPath == true {
            cell.configureWithDeselect(color: color)
        } else {
            cell.configureWithSelect(color: color)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! ColorTableViewCell
        let color = colors[indexPath.row]
        
        cell.configureWithDeselect(color: color)
        
        unselectedCellIndexPath = nil
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
            colorName = String()
            colorCode = String()
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "color" {
            let color = Color(colorName: colorName, colorCode: colorCode)
            colors.append(color)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if self.elementName == "name"{
                colorName += data
            } else if self.elementName == "code" {
                colorCode += data
            }
        }
    }
    
}
