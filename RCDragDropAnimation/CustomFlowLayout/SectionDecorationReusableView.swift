//
//  SectionDecorationReusableView.swift
//  RCSectionDecoration
//
//  Created by RongCheng on 2023/6/16.
//

import UIKit
import Kingfisher
class SectionDecorationReusableView: UICollectionReusableView {
    // 新建UIImageView
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        self.addSubview(imageView)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
        guard let att = layoutAttributes as? SectionDecorationLayoutAttributes else {
            return
        }
        self.backgroundColor = .clear
        bgImageView.frame = att.bounds
        
        if let cornerRadius = att.cornerRadius {
            bgImageView.clipsToBounds = true
            bgImageView.layer.cornerRadius = cornerRadius
        }
        
        bgImageView.backgroundColor = att.backgroundColor
        
        if let imageName = att.imageName {
            if imageName.hasPrefix("http") { // 判断是网络图片
                bgImageView.kf.setImage(with: URL(string: imageName))
            }else{
                bgImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

