//
//  ViewController.swift
//  PracticeExpandableTableView
//
//  Created by Sang Le on 11/6/17.
//  Copyright © 2017 Sang Le. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    fileprivate let viewModel = ManufactureViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.reloadSection = { [weak self] (section: Int) in
            self?.tableView?.beginUpdates()
            let indexPath = IndexPath(row: 0, section: section)
//            self?.tableView?.insertRows(at: [indexPath], with: .fade)
//            self?.tableView.insert
            self?.tableView?.reloadRows(at: [indexPath], with: .fade)
            self?.tableView?.endUpdates()
        }
        
        
        
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.sectionHeaderHeight = 70
        tableView?.delegate = viewModel
        tableView?.dataSource = viewModel
        tableView?.separatorStyle = .none
        tableView?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView?.register(ContentTableViewCell.nib, forCellReuseIdentifier: ContentTableViewCell.identifier)
    }
}

