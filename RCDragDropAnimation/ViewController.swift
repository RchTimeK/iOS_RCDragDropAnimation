//
//  ViewController.swift
//  RCDragDropAnimation
//
//  Created by RongCheng on 2023/6/14.
//

import UIKit

class ViewController: UIViewController {

    private var datas = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .green
        view.backgroundColor = .white
        navigationItem.title = "应用"
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.backgroundColor = .red
        btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        view.addSubview(btn)
        
        let names = ["手机充值","生活缴费","医疗健康","市民中心","我的快递","菜鸟","阿里健康","高德打车"]
        for i in 0..<names.count {
            var model = ItemModel()
            model.section = 1
            model.item = i
            model.name = names[i]
            datas.append(model)
        }
        
    }
    @objc private func btnClick(){
        let editVC = EditViewController()
        editVC.editItems = datas
        editVC.modalPresentationStyle = .fullScreen
        navigationController?.present(editVC, animated: true)
    }


}

