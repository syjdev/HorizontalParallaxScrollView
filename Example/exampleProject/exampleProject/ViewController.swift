//
//  ViewController.swift
//  exampleProject
//
//  Created by syjdev on 2017. 12. 2..
//  Copyright © 2017년 SYParallaxScrollView. All rights reserved.
//

import UIKit
import SYParallaxScrollView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
     
        let radius: CGFloat = 80
        
        let redCircleView = UIView(frame: CGRect(x: 0, y: 0, width: 2 * radius, height: 2 * radius))
        redCircleView.layer.cornerRadius = radius
        redCircleView.backgroundColor = UIColor.red
        let redCircleItem = SYParallaxViewItem(view: redCircleView,
                                      originOffset: CGPoint(x: view.frame.width / 2 - radius, y: 140),
                                      acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 0.65, y: 0)),
                                      progress: { (parallaxView, view) in
                                        let maxScrollDistance = parallaxView.frame.width * 0.6
                                        view.alpha = (maxScrollDistance - parallaxView.contentOffset.x) / maxScrollDistance
                                      }
        )
        
        
        let labelBottomRedCircle = UILabel(frame: CGRect(x: 0, y: 0, width: 2 * radius, height: 30))
        labelBottomRedCircle.textAlignment = .center
        labelBottomRedCircle.text = "Sample project."
        let labelBottomRedCircleItem = SYParallaxViewItem(view: labelBottomRedCircle,
                                               originOffset: CGPoint(x: view.frame.width / 2 - radius, y: 140 + 2 * radius + 30),
                                               acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 1, y: 0)),
                                               progress: { (parallaxView, view) in
                                                let maxScrollDistance = parallaxView.frame.width * 0.6
                                                view.alpha = (maxScrollDistance - parallaxView.contentOffset.x) / maxScrollDistance
                                               }
        )

        
        
        let blueCircleView = UIView(frame: CGRect(x: 0, y: 0, width: 2 * radius, height: 2 * radius))
        blueCircleView.alpha = 0
        blueCircleView.backgroundColor = UIColor.blue
        blueCircleView.layer.cornerRadius = radius
        let blueCircleItem = SYParallaxViewItem(view: blueCircleView,
                                               originOffset: CGPoint(x: view.frame.width * 1.15 - radius, y: 140),
                                               acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 0.65, y: 0)),
                                               progress: { (parallaxView, view) in
                                                if parallaxView.contentOffset.x < parallaxView.frame.width {
                                                    view.alpha = 1 - (parallaxView.frame.width - parallaxView.contentOffset.x) / parallaxView.frame.width
                                                } else {
                                                    view.alpha = (parallaxView.frame.width * 2 - parallaxView.contentOffset.x) / parallaxView.frame.width
                                                }
                                               }
        )
        
        
        let labelBottomBlueCircle = UILabel(frame: CGRect(x: 0, y: 0, width: 2 * radius, height: 30))
        labelBottomBlueCircle.alpha = 0
        labelBottomBlueCircle.textAlignment = .center
        labelBottomBlueCircle.text = "Sample project."
        let labelBottomBlueCircleItem = SYParallaxViewItem(view: labelBottomBlueCircle,
                                                          originOffset: CGPoint(x: view.frame.width * 1.5 - radius, y: 140 + 2 * radius + 30),
                                                          acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 1, y: 0)),
                                                          progress: { (parallaxView, view) in
                                                            if parallaxView.contentOffset.x < parallaxView.frame.width {
                                                                view.alpha = 1 - (parallaxView.frame.width - parallaxView.contentOffset.x) / parallaxView.frame.width
                                                            } else {
                                                                view.alpha = (parallaxView.frame.width * 2 - parallaxView.contentOffset.x) / parallaxView.frame.width
                                                            }
                                                          }
        )
        
        
        let greenCircleView = UIView(frame: CGRect(x: 0, y: 0, width: 2 * radius, height: 2 * radius))
        greenCircleView.alpha = 0
        greenCircleView.backgroundColor = UIColor.green
        greenCircleView.layer.cornerRadius = radius
        let greenCircleItem = SYParallaxViewItem(view: greenCircleView,
                                                originOffset: CGPoint(x: view.frame.width * 1.8 - radius, y: 140),
                                                acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 0.65, y: 0)),
                                                progress: { (parallaxView, view) in
                                                    if parallaxView.contentOffset.x < parallaxView.frame.width * 2 {
                                                        view.alpha = 1 - (parallaxView.frame.width * 2 - parallaxView.contentOffset.x) / parallaxView.frame.width
                                                    } else {
                                                        view.alpha = (parallaxView.frame.width * 3 - parallaxView.contentOffset.x) / parallaxView.frame.width
                                                    }
                                                    
                                                }
        )
        
        
        let labelBottomGreenCircle = UILabel(frame: CGRect(x: 0, y: 0, width: 2 * radius, height: 30))
        labelBottomGreenCircle.alpha = 0
        labelBottomGreenCircle.textAlignment = .center
        labelBottomGreenCircle.text = "Sample project."
        let labelBottomGreenCircleItem = SYParallaxViewItem(view: labelBottomGreenCircle,
                                                           originOffset: CGPoint(x: view.frame.width * 2.5 - radius, y: 140 + 2 * radius + 30),
                                                           acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 1, y: 0)),
                                                           progress: { (parallaxView, view) in
                                                            if parallaxView.contentOffset.x < parallaxView.frame.width * 2 {
                                                                view.alpha = 1 - (parallaxView.frame.width * 2 - parallaxView.contentOffset.x) / parallaxView.frame.width
                                                            } else {
                                                                view.alpha = (parallaxView.frame.width * 3 - parallaxView.contentOffset.x) / parallaxView.frame.width
                                                            }
                                                           }
        )
        
        
        let syparallaxScrollView = SYParallaxScrollViewBuilder.setOption { (option) in
            option.frame = view.frame
            option.isPagingEnabled = true
            option.parallaxViewItems = [redCircleItem, labelBottomRedCircleItem,
                                        blueCircleItem, labelBottomBlueCircleItem,
                                        greenCircleItem, labelBottomGreenCircleItem]
            option.contentWidth = view.frame.width * 3.0
        }.build()
        
        view.addSubview(syparallaxScrollView)
    }

}

