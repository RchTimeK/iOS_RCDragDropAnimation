//
//  EditViewController.swift
//  RCDragDropAnimation
//
//  Created by RongCheng on 2023/6/14.
//

import UIKit

class EditViewController: UIViewController {
    /// 从前页传入
    var editItems = [ItemModel]()
    
    private var collectionView: UICollectionView!
    private let EditAddCellID = "EditAddCellID"
    private let EditReduceCellID = "EditReduceCellID"
    private let EditHeaderID = "EditHeaderID"
    private let sectionTitles = ["首页应用","便民生活","购物娱乐","理财管理","教育公益"]
    private var datas = [[ItemModel]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cGroup
        setupNavigationView()
        setupDatas()
        setupCollectionView()
    }
    
}
private extension EditViewController {
    func setupCollectionView(){
        let itemW: CGFloat = (kWidth-20)*0.25
        let itemH: CGFloat = 80
        let layout = SectionDecorationFlowLayout()
        layout.sectionDelegate = self
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        layout.headerReferenceSize = CGSize(width: kWidth, height: 40)
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: CGRect(x: 0, y: kTopSafeArea, width: kWidth, height: kHeight-kTopSafeArea), collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .cGroup
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.dragInteractionEnabled = true
        collectionView.reorderingCadence = .immediate
        collectionView.isSpringLoaded = true
        collectionView.register(EditAddCell.self, forCellWithReuseIdentifier: EditAddCellID)
        collectionView.register(EditReduceCell.self, forCellWithReuseIdentifier: EditReduceCellID)
        collectionView.register(EditHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EditHeaderID)
        view.addSubview(collectionView)
    }
    
    func setupNavigationView(){
        let bar = UIView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kTopSafeArea))
        bar.backgroundColor = .theme
        view.addSubview(bar)
        
        let title = UILabel(frame: CGRect(x: 50, y: kStatusHeight, width: kWidth-100, height: 44))
        title.text = "应用编辑"
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        title.textAlignment = .center
        bar.addSubview(title)
        
        for i in 0...1 {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: CGFloat(i)*(kWidth-50), y: kStatusHeight, width: 50, height: 44)
            btn.setTitle(["取消","保存"][i], for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.addTarget(self, action: #selector(barItmesClick(_:)), for: .touchUpInside)
            bar.addSubview(btn)
        }
    }
    func setupDatas(){
        let names = [
            ["手机充值","生活缴费","医疗健康","市民中心","我的快递","菜鸟","阿里健康","高德打车","飞猪旅行","哈罗","国家政务"],
            ["饿了么","淘票票","消费券","淘特","彩票","口碑团购","体育服务"],
            ["花呗","芝麻信用","网商银行","余额宝"],
            ["蚂蚁森林","运动","蚂蚁庄园","芭芭农场","蚂蚁新村","神奇海洋","3小时公益","支付宝公益",]
        ]
        for i in 0..<names.count {
            let subNames = names[i]
            var items = [ItemModel]()
            for j in 0..<subNames.count {
                var model = ItemModel()
                model.section = i+1
                model.item = j
                model.name = subNames[j]
                model.isAdded = editItems.contains(where: { $0.id == model.id})
                items.append(model)
            }
            datas.append(items)
        }
    }
}
extension EditViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sectionTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return editItems.count
        }else{
            return datas[section-1].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditReduceCellID, for: indexPath) as! EditReduceCell
            cell.model = editItems[indexPath.row]
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EditAddCellID, for: indexPath) as! EditAddCell
            cell.model = datas[indexPath.section-1][indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAt(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            return UICollectionReusableView()
        }else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: EditHeaderID, for: indexPath) as! EditHeaderView
            header.title = sectionTitles[indexPath.section]
            return header
        }
    }
    
}

//MARK: -- Section背景色代理
extension EditViewController: SectionDecorationFlowLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: SectionDecorationFlowLayout, marginForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: SectionDecorationFlowLayout, cornerRadiusForSectionAt section: Int) -> CGFloat? {
        8
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: SectionDecorationFlowLayout, headerForSectionAt section: Int) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 40)
    }
    
}

//MARK: -- 拖拽代理
extension EditViewController: UICollectionViewDropDelegate,UICollectionViewDragDelegate {
    // 识别到拖动，是否响应
    // 一次拖动一个；若一次拖动多个，则需要选中多个
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if indexPath.section == 0 {
            let item = editItems[indexPath.row]
            let itemData = "\(item.section)_\(item.item)_\(item.name)"
            // NSItemProvider， 拖放处理时，携带数据的容器，通过对象初始化，该对象需满足 NSItemProviderWriting 协议
            let itemProvider = NSItemProvider(object: itemData as NSString)
            //  从一个位置，拖到另一个时，代表潜在的数据item
            let dragItem = UIDragItem(itemProvider: itemProvider)
            dragItem.localObject = itemData
            return [dragItem]
        }else{
            return [UIDragItem]()
        }
    }
    /*
    // 开始拖拽后，继续添加拖拽的任务，这里就不需要了，处理同`itemsForBeginning`方法
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {

    }
     */
    
    func collectionView(_ collectionView: UICollectionView, dragSessionWillBegin session: UIDragSession) {
        // 拖拽开始，可自行处理
    }
    func collectionView(_ collectionView: UICollectionView, dragSessionDidEnd session: UIDragSession) {
        // 拖拽结束，可自行处理
    }
    // 除去拖拽时候的阴影
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return nil
        }
        let previewParameters = UIDragPreviewParameters()
        previewParameters.visiblePath = UIBezierPath(rect: cell.bounds)
        previewParameters.backgroundColor = .white
        if #available(iOS 14.0, *) {
            previewParameters.shadowPath = UIBezierPath(rect: .zero)
        }
        return previewParameters
    }
    // 是否能放置
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }
    
    // 处理拖动中放置的策略
    // 四种分别：move移动；copy拷贝；forbidden禁止，即不能放置；cancel用户取消。
    // 效果一般使用2种：.insertAtDestinationIndexPath 挤压移动；.insertIntoDestinationIndexPath 取代。
    // 一般的用挤压的多
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if session.localDragSession != nil {
            if collectionView.hasActiveDrag {
                return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            } else {
                return UICollectionViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
            }
        } else {
            return UICollectionViewDropProposal(operation: .forbidden)
        }
    }
    // 结束放置时的处理
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        switch coordinator.proposal.operation {
        case .move:
            let items = coordinator.items
            if let item = items.first,let sourceIndexPath = item.sourceIndexPath {
                // 执行批量更新
                collectionView.performBatchUpdates { [weak self] in
                    let obj = self?.editItems.remove(at: sourceIndexPath.row)
                    self?.editItems.insert(obj!, at: destinationIndexPath.row)
                    collectionView.deleteItems(at: [sourceIndexPath])
                    collectionView.insertItems(at: [destinationIndexPath])
                }
                // 将项目动画化到视图层次结构中的任意位置
                coordinator.drop(item.dragItem, toItemAt: destinationIndexPath)
            }
            break
        case .copy:
            // 执行批量更新
            collectionView.performBatchUpdates { [weak self] in
                var indexPaths = [IndexPath]()
                for (index, item) in coordinator.items.enumerated() {
                    let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
                    let arr = (item.dragItem.localObject as! String).components(separatedBy: "_")
                    var obj = ItemModel()
                    obj.section = Int(arr.first!)!
                    obj.item = Int(arr.last!)!
                    obj.name = arr[1]
                    self?.editItems.insert(obj, at: indexPath.row)
                    indexPaths.append(indexPath)
                }
                collectionView.insertItems(at: indexPaths)
            }
            break
        default:
            return
        }
    }
    
    // 当dropSession 完成时会被调用，不管结果如何。一般进行清理或刷新操作
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnd session: UIDropSession) {
        let animationsEnabled = UIView.areAnimationsEnabled
        UIView.setAnimationsEnabled(false)
        collectionView.reloadSections(IndexSet(integer: 0))
        UIView.setAnimationsEnabled(animationsEnabled)
    }
    
    // 当drop会话进入到 collectionView 的坐标区域内就会调用
    func collectionView(_ collectionView: UICollectionView, dropSessionDidEnter session: UIDropSession) {
    }
    
    // 当 dropSession 不在collectionView 目标区域的时候会被调用
    func collectionView(_ collectionView: UICollectionView, dropSessionDidExit session: UIDropSession) {

    }
   
    // 同属性 isSpringLoaded
    func collectionView(_ collectionView: UICollectionView, shouldSpringLoadItemAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        true
    }
}

extension EditViewController {
    
    private func didSelectItemAt(_ indexPath: IndexPath){
        if indexPath.section == 0 { // 减
            reduceItme(indexPath)
        }else{ // 增
            addItem(indexPath)
        }
    }
    
    // 增加item
    private func addItem(_ indexPath: IndexPath){
        // 1、最多可以添加8个应用，可随意设置
        if editItems.count == 8{
            return
        }
        // 2、当前点击的model
        let model = datas[indexPath.section-1][indexPath.item]
        if model.isAdded { // 已经添加过了
            return
        }
        // 3、当前点击开始的cell
        let startCell = collectionView.cellForItem(at: indexPath)! as! EditAddCell
        
        // 4、collectionView插入一个item占位，此举是为了增加行或减少行的动画过渡更自然
        // 4.1、先添加一个空白的model，等移动动画结束后再给model重新赋值，刷新
        editItems.append(ItemModel())
        // 4.2、在collectionView第0区插入一个item
        collectionView.performBatchUpdates { [weak self] in
            self?.collectionView.insertItems(at: [IndexPath(row: self!.editItems.count-1, section: 0)])
        }
        
        // 5、获取最后一个空白的cell，作为移动动画终点位置
        let endCell = collectionView.cellForItem(at: IndexPath(row: editItems.count-1, section: 0))!
       
        // 6、生成动画item
        let animationItme = AnimationItem(frame: startCell.frame)
        animationItme.model = model
        collectionView.addSubview(animationItme)
        
        // 7、更新数据：
        // 7.1、更新点击model的isAdded状态
        datas[indexPath.section-1][indexPath.item].isAdded = true
        // 7.2、给第一区的新插入的最后一个cell的model赋值
        editItems.removeLast()
        editItems.append(model)

        // 8、更新icon状态；可以刷新，也可以不用再刷新collectionView
        startCell.updateIcon(true)
    
        // 9、移动动画，动画结束执行减号显示动画，减号显示动画结束，移除动画的item，刷新collectionView
        UIView.animate(withDuration: 0.3) {
            animationItme.frame = endCell.frame
        } completion: { [weak self] _ in
            // 9.1、执行减号显示动画
            animationItme.showReduceIcon {
                // 9.3、减号显示动画结束，移除动画的item
                animationItme.removeFromSuperview()
                // 9.2、刷新collectionView
                let animationsEnabled = UIView.areAnimationsEnabled
                UIView.setAnimationsEnabled(false)
                self?.collectionView.reloadSections(IndexSet(integer: 0))
                UIView.setAnimationsEnabled(animationsEnabled)
                
            }
        }
    }
    
    // 删除itme
    private func reduceItme(_ indexPath: IndexPath){
        if editItems.count == 1 {
            print("至少选择一个应用")
            return
        }
        // 1、当前点击的model
        let model = editItems[indexPath.item]
        // 2、当前点击的cell，作为移动动画起始位置
        let startCell = collectionView.cellForItem(at: indexPath)!
        // 3、获取移动动画终点位置的cell
        let endCell = collectionView.cellForItem(at: IndexPath(item: model.item, section: model.section))! as! EditAddCell
        // 4、生成移动动画的Item
        let animationItme = AnimationItem(frame: startCell.frame)
        animationItme.model = model
        collectionView.addSubview(animationItme)
        // 5、更新数据
        // 5.1、编辑区删除对应的数据
        editItems.remove(at: indexPath.item)
        // 5.2、datas区修改对应的model的isAdded值
        datas[model.section-1][model.item].isAdded = false
        // 6、更新collectionView：删除要移除的Itme
        collectionView.performBatchUpdates { [weak self] in
            self?.collectionView.deleteItems(at: [indexPath])
        } completion: { [weak self] _ in
            // 无感刷新，不会“闪烁”
            let animationsEnabled = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self?.collectionView.reloadSections(IndexSet(integer: indexPath.section))
            UIView.setAnimationsEnabled(animationsEnabled)
        }
        //7、移动动画：动画结束后，先移除动画的Item，再更新终点cell的icon状态
        UIView.animate(withDuration: 0.4) {
            animationItme.frame = endCell.frame
            animationItme.alpha = 0.5
        } completion: { _ in
            // 7.1、移除动画的Item
            animationItme.removeFromSuperview()
            // 7.2、更新icon状态；可以刷新，也可以不用再刷新collectionView，
            endCell.updateIcon(false);
        }
    }
    
    @objc private func barItmesClick(_ sender: UIButton){
        if sender.currentTitle == "取消" {
            self.dismiss(animated: true)
        }else{
            self.dismiss(animated: true)
        }
    }
   
}
/*
 1.
 在UICollectionView上添加一个长按的手势
 在UICollectionView上面添加一个浮动隐藏的cell,便于拖拽
 2.
 拖拽过程的监听
 2.1 通过长按操作找到需要被拖动的cell1
 2.2 通过拖动cell1找到找到和它交换位置的cell2
 2.3 交换cell1和cell2的位置
 2.4 替换数据源，把起始位置的数据模型删除，然后将起始位置的数据模型插入到拖拽位置

 */
