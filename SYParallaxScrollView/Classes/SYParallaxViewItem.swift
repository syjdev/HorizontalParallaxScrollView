//
//  SYParallaxViewItem.swift
//  SYParallaxViewItem
//
//  Created by syjdev@gmail.com on 11/05/2017.
//  Copyright (c) 2017 syjdev@gmail.com. All rights reserved.
//

import UIKit


public enum SYParallaxAcceleration {
    case invariable(CGPoint)
    case variable(((_ parallaxScrollView: SYParallaxScrollView, _ view: UIView) -> CGPoint))
}


public struct SYParallaxViewItem {
    public let view: UIView
    public let originOffset: CGPoint
    public let acceleration: SYParallaxAcceleration
    public let progress: ((_ parallaxScrollView: SYParallaxScrollView, _ view: UIView) -> Void)

    public init(view: UIView,
                originOffset: CGPoint = CGPoint.zero,
                acceleration: SYParallaxAcceleration,
                progress: @escaping ((_ parallaxScrollView: SYParallaxScrollView, _ view: UIView) -> Void) = { _ ,_ in }) {
        self.view = view
        self.originOffset = originOffset
        self.acceleration = acceleration
        self.progress = progress
    }
}
