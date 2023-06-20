//
//  EditViewCell.swift
//  RCDragDropAnimation
//
//  Created by RongCheng on 2023/6/14.
//

import UIKit

class EditAddCell: UICollectionViewCell {
    private var icon: UIImageView!
    private var name: UILabel!
    private var addIcon: UIImageView!
    
    func updateIcon(_ isAdded: Bool,completion: (()->())? = nil){
        if isAdded {
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.addIcon.transform = CGAffineTransformMakeScale(0.1, 0.1)
            } completion: {[weak self] _ in
                self?.addIcon.isHidden = true
                completion?()
            }
        }else{
            addIcon.isHidden = false
            addIcon.transform = CGAffineTransformMakeScale(0.1, 0.1)
            UIView.animate(withDuration: 0.2) { [weak self] in
                self?.addIcon.transform = .identity
            }completion: { _ in
                completion?()
            }
        }
    }
    
    var model: ItemModel! {
        didSet {
            icon.image = UIImage(named: "icon_\(model.id)")
            name.text = model.name
            addIcon.isHidden = model.isAdded
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
        
        addIcon = UIImageView(frame: CGRect(x: icon.right-10, y: icon.top-5, width: 20, height: 20))
        addIcon.image = UIImage(named: "edit_add")
        addIcon.setBorder(color: .white, radius: 10,lineWidth: 3)
        contentView.addSubview(addIcon)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

