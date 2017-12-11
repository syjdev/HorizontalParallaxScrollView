//
//  SYParallaxScrollView.swift
//  SYParallaxScrollView
//
//  Created by syjdev@gmail.com on 11/05/2017.
//  Copyright (c) 2017 syjdev@gmail.com. All rights reserved.
//

import UIKit


@objc
public class SYParallaxScrollViewBuilder: NSObject {
    private let parallaxScrollViewOption: SYParallaxScrollViewOption


    private init(parallaxScrollViewOption: SYParallaxScrollViewOption) {
        self.parallaxScrollViewOption = parallaxScrollViewOption
        super.init()
    }


    public class func setOption(_ closure: ((inout SYParallaxScrollViewOption) -> Void)) -> SYParallaxScrollViewBuilder {
        var option = SYParallaxScrollViewOption()
        closure(&option)
        return SYParallaxScrollViewBuilder(parallaxScrollViewOption: option)
    }


    public func build() -> SYParallaxScrollView {
        return SYParallaxScrollView(option: parallaxScrollViewOption)
    }
}


public struct SYParallaxScrollViewOption {
    public var parallaxViewItems: Array<SYParallaxViewItem>? = nil
    public var frame: CGRect = CGRect.zero
    public var isPagingEnabled: Bool = false
    public var contentWidth: CGFloat = 0
}


@objc
public protocol SYParallaxScrollViewDelegate {
    @objc optional func parallaxScrollViewWillBeginDragging(_ parallaxScrollView: SYParallaxScrollView)
    @objc optional func parallaxScrollViewDidEndDragging(_ parallaxScrollView: SYParallaxScrollView, willDecelerate decelerate: Bool)
    @objc optional func parallaxScrollViewDidScroll(_ parallaxScrollView: SYParallaxScrollView)
    @objc optional func parallaxScrollViewWillBeginDecelerating(_ parallaxScrollView: SYParallaxScrollView)
    @objc optional func parallaxScrollViewDidEndDecelerating(_ scrollView: SYParallaxScrollView)
}


@objc
public class SYParallaxScrollView : UIView, UIScrollViewDelegate {
    private let parallaxViewItems: Array<SYParallaxViewItem>
    private let internalScrollView = UIScrollView()

    public var delegate: SYParallaxScrollViewDelegate?
    public var contentOffset: CGPoint { return internalScrollView.contentOffset }
    public var contentSize: CGSize { return internalScrollView.contentSize }


    fileprivate init(option: SYParallaxScrollViewOption) {
        if let parallaxViewItems = option.parallaxViewItems {
            self.parallaxViewItems = parallaxViewItems
        } else {
            self.parallaxViewItems = Array<SYParallaxViewItem>()
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
            print("SYParallaxScrollViewOption's contentWidth not setted. It could scroll weired.")
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
