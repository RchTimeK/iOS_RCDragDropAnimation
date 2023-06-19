//
//  ItemModel.swift
//  RCDragDropAnimation
//
//  Created by RongCheng on 2023/6/14.
//

import Foundation

struct ItemModel {
    // 分类
    var section: Int = -1
    // 索引
    var item: Int = -1
    // 名称
    var name: String = ""
    // 是否添加
    var isAdded: Bool = false
    // id
    var id: String {
        get {
            "\(section)_\(item)"
        }
    }
    init(){}
}
