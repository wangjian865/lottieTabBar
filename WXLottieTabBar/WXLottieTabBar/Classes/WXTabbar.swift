//
//  WXTabbar.swift
//  WXAnimationTabbar
//
//  Created by WX on 2021/1/14.
//

import UIKit

protocol AETabbarDelegate {
    func tabbar(tab: WXTabbar, didSelectItem item: WXTabbarItem, atIndex index: NSInteger )
}

class WXTabbar: UITabBar {

    var aeItems: [WXTabbarItem]?
    var aeDelegate: AETabbarDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        if let tClass = NSClassFromString("UITabBarButton") {
            for subView in subviews {
                if subView.isKind(of: tClass) {
                    subView.removeFromSuperview()
                }
            }
        }
        setupItems()
    }
    func setupItems() {
        let count = aeItems?.count ?? 1
        let width: CGFloat = frame.size.width/CGFloat(count)
        let height: CGFloat = frame.size.height
        for idx in 0...(count-1) {
            let item = aeItems![idx]
            item.backgroundColor = .white
            item.frame = CGRect(x: CGFloat(idx)*width, y: 0, width: width, height: height)
            addSubview(item)
            item.delegate = self
        }
    }
    
}

extension WXTabbar: AETabbarItemDelegate {
    func tabbarItem(item: WXTabbarItem, didSelectIndex index: NSInteger) {
        if aeDelegate != nil {
            aeDelegate?.tabbar(tab: self, didSelectItem: item, atIndex: index)
        }
    }
}
