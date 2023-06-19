//
//  AppDelegate.swift
//  RCDragDropAnimation
//
//  Created by RongCheng on 2023/6/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window  else{
            return true
        }
        setupConstant(application)
        window.backgroundColor = .white
        window.rootViewController = NavigationController(rootViewController: ViewController())
        window.makeKeyAndVisible()
        return true
    }
    
    private func setupConstant(_ application: UIApplication){
        kHeight = UIScreen.main.bounds.height
        kWidth = UIScreen.main.bounds.width
        kStatusHeight = application.statusBarFrame.size.height
        kNavigationBarHeight = UINavigationController().navigationBar.frame.size.height
        kTabBarHeight = UITabBarController().tabBar.frame.size.height
        kBottomInsetsSafeArea = window!.safeAreaInsets.bottom
        kTopInsetsSafeArea = window!.safeAreaInsets.top
        kTopSafeArea = kStatusHeight + kNavigationBarHeight
    }
}



class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance.init()
            appearance.backgroundColor = .theme
            appearance.shadowImage = UIImage()
            appearance.titleTextAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .medium),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        }else{
            let bar = UINavigationBar.appearance()
            bar.backgroundColor = .theme
            bar.titleTextAttributes = [
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18, weight: .medium),
                NSAttributedString.Key.foregroundColor : UIColor.white
            ]
            bar.shadowImage = UIImage()
        }
    }
}
extension UIColor {
    static let theme: UIColor = hexString("0C7FE9")
    static let c1: UIColor = hexString("111111")
    static let c2: UIColor = hexString("222222")
    static let c3: UIColor = hexString("333333")
    static let c4: UIColor = hexString("444444")
    static let c5: UIColor = hexString("555555")
    static let c6: UIColor = hexString("666666")
    static let c7: UIColor = hexString("777777")
    static let c8: UIColor = hexString("888888")
    static let c9: UIColor = hexString("999999")
    static let cA: UIColor = hexString("AAAAAA")
    static let cB: UIColor = hexString("BBBBBB")
    static let cC: UIColor = hexString("CCCCCC")
    static let cD: UIColor = hexString("DDDDDD")
    static let cE: UIColor = hexString("EEEEEE")
    static let cF7: UIColor = hexString("F7F7F7")
    static let cRed: UIColor = hexString("FF4053")
    static let cGroup: UIColor = {
        if #available(iOS 13.0, *) {
            return .systemGroupedBackground
        }else {
           return .groupTableViewBackground
        }
    }()
    
    static func hexString(_ string: String) -> UIColor {
        var tempStr = string
        if tempStr.hasPrefix("#") {
            tempStr = String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 1)...])
        }
        assert(tempStr.count == 6, "颜色位数错误")
        
        var red: UInt64 = 0, green: UInt64 = 0, blue: UInt64 = 0
        
        Scanner(string: String(tempStr[..<tempStr.index(tempStr.startIndex, offsetBy: 2)])).scanHexInt64(&red)
        
        Scanner(string: String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 2)..<tempStr.index(tempStr.startIndex, offsetBy: 4)])).scanHexInt64(&green)
        
        Scanner(string: String(tempStr[tempStr.index(tempStr.startIndex, offsetBy: 4)...])).scanHexInt64(&blue)
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
    
    static func randomColor() -> UIColor {
        let red = arc4random() % 255
        let green = arc4random() % 255
        let blue = arc4random() % 255
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue:  CGFloat(blue)/255.0, alpha: 1.0)
    }
}

extension UIView {
    /// 上
    var top:CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            self.frame.origin.y
        }
    }
    /// 左
    var left: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            self.frame.origin.x
        }
    }
    /// 下
    var bottom: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame;
        }
        get {
            self.frame.origin.y + self.frame.size.height
        }
    }
    /// 右
    var right: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {
            self.frame.origin.x + self.frame.size.width
        }
    }
    /// 宽
    var width: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            self.frame.size.width
        }
    }
    /// 高
    var height: CGFloat {
        set {
            var frame: CGRect = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            self.frame.size.height
        }
    }
    
    /// 中心点x
    var centerX: CGFloat {
        set{
            left = newValue - width * 0.5
        }
        get {
            left + width * 0.5
        }
    }
    
    /// 中心点y
    var centerY: CGFloat {
        set{
            top = newValue - height * 0.5
        }
        get {
            top + height * 0.5
        }
    }

    /// 设置圆角，默认8（frame须设置）
    func setCornerRadius(_ radius: CGFloat = 8){
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
        shapeLayer.frame = self.layer.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    /// 设置单边圆角（frame须设置）
    func setCornerRadius(_ radius: CGFloat,corners: UIRectCorner){
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        shapeLayer.frame = self.layer.bounds
        shapeLayer.path = path.cgPath
        self.layer.mask = shapeLayer
    }
    
    /// 设置阴影+圆角，默认颜色ColorD、圆角5
    func setShadowAndRadius(color: UIColor = .cE,radius: CGFloat = 5){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = radius
        self.layer.cornerRadius = radius
    }
    
    /// 设置边框
    func setBorder(color: UIColor = .theme,radius: CGFloat = 5,lineWidth: CGFloat = 1){
        layer.borderColor = color.cgColor
        layer.borderWidth = lineWidth
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}

/**屏幕高度**/
var kHeight: CGFloat = 0.0
/**屏幕宽度**/
var kWidth:CGFloat = 0.0
/**状态栏高度**/
var kStatusHeight: CGFloat = 0.0
/**status+nav**/
var kTopSafeArea: CGFloat = 0.0
/**底部安全区域**/
var kBottomInsetsSafeArea: CGFloat = 0.0
/** 顶部 安全区域 */
var kTopInsetsSafeArea: CGFloat = 0.0;
/**导航条高度**/
var kNavigationBarHeight: CGFloat = 0.0
/**tabBar高度*/
var kTabBarHeight: CGFloat = 0.0
/**底部安全区域 + tabBar**/
var kBottomSafeArea: CGFloat = 0.0
