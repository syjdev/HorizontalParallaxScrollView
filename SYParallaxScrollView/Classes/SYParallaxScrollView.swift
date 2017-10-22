//
//  SYParallaxScrollView.swift
//  SYParallaxScrollView
//
//  Created by syjdev@gmail.com on 10/21/2017.
//  Copyright (c) 2017 syjdev@gmail.com. All rights reserved.
//

import UIKit

@objc class SYParallaxScrollViewBuilder: NSObject {
    private let parallaxScrollViewOption: SYParallaxScrollViewOption

    
    private init(parallaxScrollViewOption: SYParallaxScrollViewOption) {
        self.parallaxScrollViewOption = parallaxScrollViewOption
        super.init()
    }


    class func setOption(_ closure: ((inout SYParallaxScrollViewOption) -> Void)) -> SYParallaxScrollViewBuilder {
        var option = SYParallaxScrollViewOption(parallaxViewItems: nil, frame: CGRect.zero, isPagingEnabled: false)
        closure(&option)
        return SYParallaxScrollViewBuilder(parallaxScrollViewOption: option)
    }


    func build() -> SYParallaxScrollView {
        return SYParallaxScrollView(option: parallaxScrollViewOption)
    }
}


struct SYParallaxScrollViewOption {
    var parallaxViewItems: Array<SYParallaxViewItem>?
    var frame: CGRect
    var isPagingEnabled: Bool
}


@objc protocol SYParallaxScrollViewDelegate {
    @objc optional func parallaxScrollViewWillBeginDragging(_ parallaxScrollView: SYParallaxScrollView)
    @objc optional func parallaxScrollViewDidEndDragging(_ parallaxScrollView: SYParallaxScrollView, willDecelerate decelerate: Bool)
    @objc optional func parallaxScrollViewDidScroll(_ parallaxScrollView: SYParallaxScrollView)
    @objc optional func parallaxScrollViewWillBeginDecelerating(_ parallaxScrollView: SYParallaxScrollView)
    @objc optional func parallaxScrollViewDidEndDecelerating(_ scrollView: SYParallaxScrollView)
}


@objc class SYParallaxScrollView : UIView, UIScrollViewDelegate {
    private let parallaxViewItems: Array<SYParallaxViewItem>
    private let internalScrollView = UIScrollView()

    var delegate: SYParallaxScrollViewDelegate?
    var contentOffset: CGPoint { return internalScrollView.contentOffset }
    var contentSize: CGSize { return internalScrollView.contentSize }


    fileprivate init(option: SYParallaxScrollViewOption) {
        if let parallaxViewItems = option.parallaxViewItems {
            self.parallaxViewItems = parallaxViewItems
        } else {
            self.parallaxViewItems = Array<SYParallaxViewItem>()
        }


        super.init(frame: option.frame)
        internalScrollView.delegate = self
        internalScrollView.isPagingEnabled = option.isPagingEnabled

        setupViews()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        internalScrollView.contentSize = CGSize(width: maxX,
                                          height: frame.size.height)
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegate?.parallaxScrollViewWillBeginDragging?(self)
    }


    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegate?.parallaxScrollViewDidEndDragging?(self, willDecelerate: decelerate)
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        affineTransformParallaxItems()
        for parallaxScrollViewItem in parallaxViewItems {
            parallaxScrollViewItem.progress(self, parallaxScrollViewItem.view)
        }
        delegate?.parallaxScrollViewDidScroll?(self)
    }


    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegate?.parallaxScrollViewWillBeginDecelerating?(self)
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.parallaxScrollViewDidEndDecelerating?(self)
    }
}
