//
//  ManufactureTableViewCell.swift
//  PracticeExpandableTableView
//
//  Created by Sang Le on 11/6/17.
//  Copyright © 2017 Sang Le. All rights reserved.
//

import Foundation
import UIKit

class ManufactureTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: ManufactureViewModelItem? {
        didSet {
            guard let item = item as? SectionContentItem else {
                return
            }
            
            descriptionLabel.text = item.description
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
