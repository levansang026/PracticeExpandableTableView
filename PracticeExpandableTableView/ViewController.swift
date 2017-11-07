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
        
        viewModel.reloadSection = { [weak self] (section: Int, collapsed: Bool) in
            self?.tableView?.beginUpdates()
            let indexPath = IndexPath(row: 0, section: section)
            if !collapsed {
                self?.tableView?.insertRows(at: [indexPath], with: .fade)
                print("inserted")
            } else {
                self?.tableView?.deleteRows(at: [indexPath], with: .fade)
                print("deleted")
            }
            self?.tableView?.endUpdates()
            self?.tableView?.scrollRectToVisible((self?.tableView?.rect(forSection: section))!, animated: true)
        }
        
        
        
        tableView?.estimatedRowHeight = 100
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.delegate = viewModel
        tableView?.dataSource = viewModel
        tableView?.separatorStyle = .none
        tableView?.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
        tableView?.register(ContentTableViewCell.nib, forCellReuseIdentifier: ContentTableViewCell.identifier)
    }
}

