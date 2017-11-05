//
//  ViewController.swift
//  SYParallaxScrollView
//
//  Created by syjdev@gmail.com on 10/21/2017.
//  Copyright (c) 2017 syjdev@gmail.com. All rights reserved.
//

import UIKit
import SYParallaxScrollView

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        

//        SYParallaxScrollViewVersionNumber
    }
}

//class ViewController: UIViewController, SYParallaxScrollViewDelegate {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let dynamicAcceleration = SYParallaxAcceleration.variable { (parallaxView, view) -> CGPoint in
//            let progressRatio = (parallaxView.contentSize.width - 3 * parallaxView.contentOffset.x) / parallaxView.contentSize.width
//            return CGPoint(x: 0.65 * progressRatio, y: 0.65 * (1 - progressRatio))
//        }
//        let radius: CGFloat = 90
//        let redCircleView = UIView(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
//        redCircleView.layer.cornerRadius = radius
//        redCircleView.backgroundColor = UIColor.red
//        let item1 = SYParallaxViewItem(view: redCircleView,
//                                             originOffset: CGPoint(x: 50, y: 40),
//                                             acceleration: dynamicAcceleration,
//                                             progress: { (parallaxView, view) in
//        })
//
//        let greenRectView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
//        greenRectView.backgroundColor = UIColor.green
//        let item2 = SYParallaxViewItem(view: greenRectView,
//                                             originOffset: CGPoint(x: 150, y: 80),
//                                             acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 1, y: 1)),
//                                             progress: { (parallaxView, view) in
//                                                view.alpha = (parallaxView.contentSize.width - 2 * parallaxView.contentOffset.x) / parallaxView.contentSize.width
//                                        })
//
//
//        let blueRectView = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
//        blueRectView.backgroundColor = UIColor.blue
//        let item3 = SYParallaxViewItem(view: blueRectView,
//                                       originOffset: CGPoint(x: 250, y: 0),
//                                       acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 0.65, y: 0)),
//                                       progress: { (parallaxView, view) in
//        })
//
//
//        let brownRectView = UIView(frame: CGRect(x: 0, y: 0, width: 160, height: 160))
//        brownRectView.backgroundColor = UIColor.brown
//        let item4 = SYParallaxViewItem(view: brownRectView,
//                                       originOffset: CGPoint(x: 650, y: 0),
//                                       acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 0.65, y: 0)),
//                                       progress: { (parallaxView, view) in
//        })
//
//
//        let parallaxView = SYParallaxScrollViewBuilder.setOption { (option) in
//            option.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height - 100)
//            option.parallaxViewItems = [item1, item2, item3, item4]
//            option.isPagingEnabled = false
//        }.build()
//
//        view.addSubview(parallaxView)
//    }
//}

