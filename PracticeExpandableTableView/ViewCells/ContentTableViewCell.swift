//
//  ContentTableViewCell.swift
//  PracticeExpandableTableView
//
//  Created by Sang Le on 11/6/17.
//  Copyright © 2017 Sang Le. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var desLabel: UILabel?
    
    var item: ManufactureViewModelItem? {
        didSet {
            guard let item = item as? SectionContentItem else {
                return
            }
            desLabel?.text = item.description
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}
