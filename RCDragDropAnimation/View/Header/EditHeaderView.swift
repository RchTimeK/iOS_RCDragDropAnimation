//
//  EditHeaderView.swift
//  RCDragDropAnimation
//
//  Created by RongCheng on 2023/6/14.
//

import UIKit

class EditHeaderView: UICollectionReusableView {
    
    private var label: UILabel!
    
    var title: String! {
        didSet {
            label.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        label = UILabel(frame: CGRect(x: 20, y: 0, width: kWidth-40, height: 40))
        label.textColor = .c3
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        self.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
