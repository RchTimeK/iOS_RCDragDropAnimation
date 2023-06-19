//
//  AnimationItem.swift
//  RCDragDropAnimation
//
//  Created by RongCheng on 2023/6/16.
//

import UIKit

class AnimationItem: UIView {

    /// 显示减号
    func showReduceIcon(_ finish: (()->())? = nil){
        reduceIcon.isHidden = false
        reduceIcon.transform = CGAffineTransformMakeScale(0.1, 0.1)
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.reduceIcon.transform = .identity
        }completion: { _ in
            finish?()
        }
    }
    
    var model: ItemModel! {
        didSet {
            image.image = UIImage(named: "icon_\(model.id)")
            name.text = model.name
        }
    }
    
    private var reduceIcon: UIImageView!
    private var image: UIImageView!
    private var name: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image = UIImageView(frame: CGRect(x: (self.width-40)*0.5, y: 8, width: 40, height: 40))
        image.contentMode = .center
        self.addSubview(image)
        
        name = UILabel(frame: CGRect(x: 0, y: image.bottom+5, width: self.width, height: 20))
        name.textColor = .c3
        name.textAlignment = .center
        name.font = UIFont.systemFont(ofSize: 14)
        self.addSubview(name)
        
        reduceIcon = UIImageView(frame: CGRect(x: image.right-10, y: image.top-5, width: 20, height: 20))
        reduceIcon.image = UIImage(named: "edit_reduce")
        reduceIcon.layer.masksToBounds = true
        reduceIcon.layer.cornerRadius = 10
        reduceIcon.layer.borderWidth = 3
        reduceIcon.layer.borderColor = UIColor.white.cgColor
        reduceIcon.isHidden = true
        self.addSubview(reduceIcon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

