//
//  Model.swift
//  PracticeExpandableTableView
//
//  Created by Sang Le on 11/6/17.
//  Copyright © 2017 Sang Le. All rights reserved.
//

import Foundation
import UIKit

protocol ManufactureViewModelItem {
    var name: String { get }
    var description: String { get set }
    var isCollapsible: Bool { get }
    var isCollapsed: Bool { get set }
    var rowCount: Int { get }
}

extension ManufactureViewModelItem {
    var rowCount: Int {
        return 1
    }
    
    var isCollapsible: Bool {
        return true
    }
}

class ManufactureViewModel: NSObject {
    var items = [ManufactureViewModelItem]()
    var expandedItem = [Int: ManufactureViewModelItem]()
    fileprivate var headers: [HeaderView] = []
    
    var reloadSection: ((_ section: Int, _ collapsed: Bool) -> Void)?
    
    override init() {
        super.init()
        
        let des: String = "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean. Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts. Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean."
        
        let manufactureNames = ["Apple", "HTC", "LG", "Oppo", "Samsung", "Sony"]
        
        items.append(SectionContentItem(name: manufactureNames[0], description: des))
        items.append(SectionContentItem(name: manufactureNames[1], description: des))
        items.append(SectionContentItem(name: manufactureNames[2], description: des))
        items.append(SectionContentItem(name: manufactureNames[3], description: des))
        items.append(SectionContentItem(name: manufactureNames[4], description: des))
        items.append(SectionContentItem(name: manufactureNames[5], description: des))
    }
}

extension ManufactureViewModel: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ContentTableViewCell.identifier, for: indexPath) as? ContentTableViewCell {
            cell.item = items[indexPath.section]
            print("loaded row of section: \(indexPath.section)")
            return cell
        }
        
        return UITableViewCell()
    }
}

extension ManufactureViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var headerView = HeaderView()
        if headers.count > section {
            headerView = headers[section]
        } else {
            headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as! HeaderView
            headers.append(headerView)
        }
        
        let item = items[section]
        headerView.item = item
        headerView.delegate = self
        headerView.section = section
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if items[indexPath.section].isCollapsed {
            return 0
        }
        
        return UITableViewAutomaticDimension
    }
}

extension ManufactureViewModel: HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int) {
        var item = items[section]
        
        if item.isCollapsible {
            
            if (section >= 0) {
                let collapsed = !item.isCollapsed
                item.isCollapsed = collapsed
                header.setCollapsed(collapsed: collapsed)
                reloadSection?(section, collapsed)
            }
        }
    }
}

class SectionContentItem: ManufactureViewModelItem {
    
    var name: String
    
    var description: String
    
    var isCollapsed = true
    
    var isCollpsible: Bool {
        return true
    }
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}
