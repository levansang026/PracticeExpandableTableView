//
//  UITableViewHeaderView.swift
//  PracticeExpandableTableView
//
//  Created by Sang Le on 11/6/17.
//  Copyright © 2017 Sang Le. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func rorate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.layer.add(animation, forKey: nil)
    }
}

protocol HeaderViewDelegate {
    func toggleSection(header: HeaderView, section: Int)
}

class HeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var arrowImageView: UIImageView?
    @IBOutlet weak var backView: UIView?

    var item: ManufactureViewModelItem? {
        didSet {
            guard let item = item else {
                return
            }

            arrowImageView?.image = #imageLiteral(resourceName: "triangle-img")
            titleLabel?.text = item.name
            setCollapsed(collapsed: item.isCollapsed)
        }
    }
    
    var delegate: HeaderViewDelegate?
    var section: Int = 0
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    func setCollapsed(collapsed: Bool) {
        arrowImageView?.rorate(collapsed ? 0.0 : .pi)
    }
    
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        arrowImageView?.image = nil
    }
}
