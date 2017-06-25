//
//  ParallaxScrollView.swift
//  ParallaxScrollView
//
//  Created by syjdev on 2017. 6. 24..
//  Copyright © 2017년 syjdev. All rights reserved.
//

import UIKit

fileprivate let defaultAccelerationPoint : CGPoint = CGPoint(x: 1.0, y: 1.0)

public class ParallaxScrollViewBuilder: NSObject {
    internal var isPagingEnabled: Bool = false
    internal var viewSize: CGSize = CGSize.zero
    internal var numberOfPages: UInt = 0
    var protectionLevelTest1: UInt = 0
    var protectionLevelTest2: UInt = 2

    //pageEnable
//    func configure {
//
//    }

//    var setting: ViewOption {
//        return ViewOption(self)
//    }
}



public class ViewOption {
    private var isPagingEnabled: Bool = false
    private var viewSize: CGSize = CGSize.zero
    private var numberOfPages: UInt = 0

    private let builder: ParallaxScrollViewBuilder


    init(_ builder: ParallaxScrollViewBuilder) {
        self.builder = builder
    }


    func setPagingEnabled(_ isPagingEnabled: Bool) -> Self {
        builder.isPagingEnabled = isPagingEnabled
        return self
    }


    func setViewSize(_ viewSize: CGSize) -> Self {
        builder.viewSize = viewSize
        return self
    }


    func setNumberOfPages(_ numberOfPages: UInt) -> Self {
        self.numberOfPages = numberOfPages
        return self
    }


    var subviews: Subviews {
        return Subviews()
    }


}


class Subviews {

}





class ParallaxScrollView: UIScrollView {

}
