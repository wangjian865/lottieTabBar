//
//  WXTabbarController.swift
//  WXAnimationTabbar
//
//  Created by WX on 2021/1/14.
//

import UIKit

class WXTabbarController: UITabBarController, UITabBarControllerDelegate, AETabbarDelegate {
    
    
    lazy var customTabbar: WXTabbar = {
        let temp = WXTabbar.init()
        temp.backgroundColor = .white
        temp.aeDelegate = self
        
        return temp
    }()
    
    var aeViewControllers: [UIViewController]?
    var currentItem: NSInteger?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        selectedIndex = 0
        setupChildVC()
        delegate = self
    }
    func setupChildVC() {
        let avc = UIViewController()
        avc.view.backgroundColor = .red
        let bvc = UIViewController()
        let cvc = UIViewController()
        let dvc = UIViewController()
        aeViewControllers = [avc,bvc,cvc,dvc]
        setupCustomTabBarItems()
    }
    
    func setupCustomTabBarItems() {
        tabBar.isHidden = true
        let animationJsonNameArray = ["fangzi","huiyuan","dingdan","wode"]
        var items: [WXTabbarItem] = []
        for idx in 0...(aeViewControllers!.count - 1) {
            let item = WXTabbarItem.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            item.animationJsonName = animationJsonNameArray[idx]
            items.append(item)
            item.tag = idx
        }
        setBeginItemAnimation(itemView: items[0], item: 0)
        customTabbar.aeItems = items
        view.addSubview(customTabbar)
        customTabbar.frame = CGRect(x: 0, y: view.frame.height - 48, width: UIScreen.main.bounds.width, height: 48)
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    }
    func tabbar(tab: WXTabbar, didSelectItem item: WXTabbarItem, atIndex index: NSInteger) {
        if currentItem != index {
            let oldItem = tab.aeItems![currentItem ?? 0] as WXTabbarItem
            setStopItemAnimationWithItem(item: oldItem)
            setBeginItemAnimation(itemView: item, item: index)
        }
        selectedIndex = index
    }
    
    func setBeginItemAnimation(itemView: WXTabbarItem, item: NSInteger) {
        for view in itemView.subviews {
            if let temp = view as? LOTAnimationView {
                if temp.isKind(of: NSClassFromString("LOTAnimationView")!) {
                    if temp.animationProgress == 0{
                        currentItem = item
                        temp.play(toProgress: 0.5) { (flag) in
                            print(flag)
                        }
                    }
                    break
                }
            }
        }
    }
    
    func setStopItemAnimationWithItem(item: WXTabbarItem) {
        for view in item.subviews {
            if view.isKind(of: NSClassFromString("LOTAnimationView")!) {
                let animationView = view as! LOTAnimationView
                animationView.stop()
            }
        }
    }
}
