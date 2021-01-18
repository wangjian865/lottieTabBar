//
//  WXTabbarItem.swift
//  WXAnimationTabbar
//
//  Created by WX on 2021/1/14.
//

import UIKit

protocol AETabbarItemDelegate {
    ///处理点击事件
    func tabbarItem(item: WXTabbarItem, didSelectIndex index: NSInteger)
}
class WXTabbarItem: UIView {
    let defaultTag = 100000
    var animationJsonName: String?{
        didSet{
            animationView.setAnimation(named: animationJsonName ?? "")
        }
    }
    var delegate: AETabbarItemDelegate?
    
    private var _tag: Int?
    override var tag: Int{
        set{
            _tag = newValue + defaultTag
        }
        get{
            return _tag ?? 0
        }
    }
    private lazy var animationView: LOTAnimationView = {
        let temp = LOTAnimationView()
        temp.contentMode = .scaleAspectFit
        return temp
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(animationView)
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapItem(_:)))
        animationView.addGestureRecognizer(tap)
    }
    @objc func tapItem(_ tap: UITapGestureRecognizer) {
        if delegate != nil {
            delegate?.tabbarItem(item: self, didSelectIndex: tag - defaultTag)
        }
    }
    func setAnimationJsonName(animationJsonName: String) {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        var rect = frame
        rect.origin.x = 0
        rect.origin.y = -35
        rect.size.height += 20
        animationView.frame = rect
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

