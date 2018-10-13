//
//  HorizontalParallaxScrollView.swift
//  HorizontalParallaxScrollView
//
//  Created by syjdev on 13/10/2018.
//

import UIKit


@objc
public class HorizontalParallaxScrollViewBuilder: NSObject {
    private let parallaxScrollViewOption: HorizontalParallaxScrollViewOption
    
    
    private init(parallaxScrollViewOption: HorizontalParallaxScrollViewOption) {
        self.parallaxScrollViewOption = parallaxScrollViewOption
        super.init()
    }
    
    public class func setOption(_ closure: ((inout HorizontalParallaxScrollViewOption) -> Void)) -> HorizontalParallaxScrollViewBuilder {
        var option = HorizontalParallaxScrollViewOption()
        closure(&option)
        return HorizontalParallaxScrollViewBuilder(parallaxScrollViewOption: option)
    }
    
    public func build() -> HorizontalParallaxScrollView {
        return HorizontalParallaxScrollView(option: parallaxScrollViewOption)
    }
}


public struct HorizontalParallaxScrollViewOption {
    public var parallaxViewItems: Array<HorizontalParallaxScrollViewItem>? = nil
    public var frame: CGRect = CGRect.zero
    public var isPagingEnabled: Bool = false
    public var contentWidth: CGFloat = 0
}


@objc
public protocol HorizontalParallaxScrollViewDelegate {
    @objc optional func parallaxScrollViewWillBeginDragging(_ parallaxScrollView: HorizontalParallaxScrollView)
    @objc optional func parallaxScrollViewDidEndDragging(_ parallaxScrollView: HorizontalParallaxScrollView, willDecelerate decelerate: Bool)
    @objc optional func parallaxScrollViewDidScroll(_ parallaxScrollView: HorizontalParallaxScrollView)
    @objc optional func parallaxScrollViewWillBeginDecelerating(_ parallaxScrollView: HorizontalParallaxScrollView)
    @objc optional func parallaxScrollViewDidEndDecelerating(_ scrollView: HorizontalParallaxScrollView)
}


@objc
public class HorizontalParallaxScrollView : UIView, UIScrollViewDelegate {
    private let parallaxViewItems: Array<HorizontalParallaxScrollViewItem>
    private let internalScrollView = UIScrollView()
    
    public var delegate: HorizontalParallaxScrollViewDelegate?
    public var contentOffset: CGPoint { return internalScrollView.contentOffset }
    public var contentSize: CGSize { return internalScrollView.contentSize }
    
    
    fileprivate init(option: HorizontalParallaxScrollViewOption) {
        if let parallaxViewItems = option.parallaxViewItems {
            self.parallaxViewItems = parallaxViewItems
        } else {
            self.parallaxViewItems = Array<HorizontalParallaxScrollViewItem>()
        }
        
        super.init(frame: option.frame)
        
        internalScrollView.contentSize = CGSize(width: option.contentWidth, height: option.frame.size.height)
        internalScrollView.delegate = self
        internalScrollView.showsHorizontalScrollIndicator = false
        internalScrollView.showsVerticalScrollIndicator = false
        internalScrollView.isPagingEnabled = option.isPagingEnabled
        
        setupViews()
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not allowed")
    }
    
    
    private func setupViews() {
        internalScrollView.frame = frame
        addSubview(internalScrollView)
        
        var maxX: CGFloat = 0
        for parallaxScrollViewItem in parallaxViewItems {
            parallaxScrollViewItem.view.frame.origin = parallaxScrollViewItem.originOffset
            if maxX < parallaxScrollViewItem.view.frame.maxX {
                maxX = parallaxScrollViewItem.view.frame.maxX
            }
            internalScrollView.addSubview(parallaxScrollViewItem.view)
        }
        
        if internalScrollView.contentSize == CGSize.zero {
            #if DEBUG
            print("HorizontalParallaxScrollViewOption's contentWidth not setted. It could scroll weired.")
            #endif
            let multiplier = CGFloat(Int(maxX / frame.size.width) + 1)
            internalScrollView.contentSize = CGSize(width: multiplier * frame.size.width,
                                                    height: frame.size.height)
        }
    }
    
    private func affineTransformParallaxItems() {
        super.layoutSubviews()
        let contentOffsetX = internalScrollView.contentOffset.x
        
        for parallaxScrollViewItem in parallaxViewItems {
            var acceleration = CGPoint.zero
            
            switch(parallaxScrollViewItem.acceleration) {
            case .invariable(let invariableAcceleration) :
                acceleration = invariableAcceleration
                break
            case .variable(let closure):
                acceleration = closure(self, parallaxScrollViewItem.view)
                break
            }
            
            parallaxScrollViewItem.view.layer.setAffineTransform(CGAffineTransform(translationX: contentOffsetX * (1.0 - acceleration.x),
                                                                                   y: contentOffsetX * acceleration.y))
        }
    }
    
    
    //MARK: UIScrollViewDelegate
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.parallaxScrollViewWillBeginDragging?(self)
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.parallaxScrollViewDidEndDragging?(self, willDecelerate: decelerate)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        affineTransformParallaxItems()
        for parallaxScrollViewItem in parallaxViewItems {
            parallaxScrollViewItem.progress(self, parallaxScrollViewItem.view)
        }
        delegate?.parallaxScrollViewDidScroll?(self)
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegate?.parallaxScrollViewWillBeginDecelerating?(self)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.parallaxScrollViewDidEndDecelerating?(self)
    }
}
