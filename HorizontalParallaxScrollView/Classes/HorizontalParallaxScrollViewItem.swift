//
//  HorizontalParallaxScrollViewItem.swift
//  HorizontalParallaxScrollView
//
//  Created by syjdev on 13/10/2018.
//

import UIKit


public enum ParallaxAcceleration {
    case invariable(CGPoint)
    case variable(((_ parallaxScrollView: HorizontalParallaxScrollView, _ view: UIView) -> CGPoint))
}


public struct HorizontalParallaxScrollViewItem {
    let view: UIView
    let originOffset: CGPoint
    let acceleration: ParallaxAcceleration
    let progress: ((_ parallaxScrollView: HorizontalParallaxScrollView, _ view: UIView) -> Void)
    
    public init(view: UIView,
                originOffset: CGPoint = CGPoint.zero,
                acceleration: ParallaxAcceleration,
                progress: @escaping ((_ parallaxScrollView: HorizontalParallaxScrollView, _ view: UIView) -> Void) = { _ ,_ in }) {
        self.view = view
        self.originOffset = originOffset
        self.acceleration = acceleration
        self.progress = progress
    }
}

