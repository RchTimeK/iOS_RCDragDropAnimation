//
//  EditReduceCell.swift
//  RCDragDropAnimation
//
//  Created by RongCheng on 2023/6/14.
//

import UIKit

class EditReduceCell: UICollectionViewCell {
    private var icon: UIImageView!
    private var name: UILabel!
    private var reduceIcon: UIImageView!
    
    var model: ItemModel! {
        didSet {
            icon.image = UIImage(named: "icon_\(model.id)")
            name.text = model.name
            reduceIcon.isHidden = model.section == -1
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI(){
        let w = (kWidth-20)*0.25
        
        icon = UIImageView(frame: CGRect(x: (w-40)*0.5, y: 8, width: 40, height: 40))
        icon.contentMode = .center
        contentView.addSubview(icon)
        
        name = UILabel(frame: CGRect(x: 0, y: icon.bottom+5, width: w, height: 20))
        name.textColor = .c3
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(name)
        
        reduceIcon = UIImageView(frame: CGRect(x: icon.right-10, y: icon.top-5, width: 20, height: 20))
        reduceIcon.image = UIImage(named: "edit_reduce")
        reduceIcon.setBorder(color: .white, radius: 10,lineWidth: 3)
        contentView.addSubview(reduceIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
