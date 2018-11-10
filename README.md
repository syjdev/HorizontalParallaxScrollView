# HorizontalParallaxScrollView

[![Version](https://img.shields.io/cocoapods/v/HorizontalParallaxScrollView.svg?style=flat)](http://cocoapods.org/pods/HorizontalParallaxScrollView)
[![License](https://img.shields.io/cocoapods/l/HorizontalParallaxScrollView.svg?style=flat)](http://cocoapods.org/pods/HorizontalParallaxScrollView)
[![Platform](https://img.shields.io/cocoapods/p/HorizontalParallaxScrollView.svg?style=flat)](http://cocoapods.org/pods/HorizontalParallaxScrollView)

![Demo Animation](https://imgur.com/kOxmsHr.gif "Demo")

You can see above demo project code.
![demo project code](https://github.com/syjdev/HorizontalParallaxScrollView/tree/master/Example)


## Usage

- First, You have to define `HorizontalParallaxScrollView` object.

```swift
let view = UIView(frame: CGRect(x: ?, y: ?, width: ?, height: ?))
let item = HorizontalParallaxScrollViewItem(view: view,
                                            originOffset: CGPoint(x: 150, y: 80),
                                            acceleration: ParallaxAcceleration.invariable(CGPoint(x: 1, y: 1)),
                                            progress: { (parallaxView, view) in
                                                //...
                                            })
```

If you want, You can define a dynamic acceleration.

```swift
let dynamicAcceleration = ParallaxAcceleration.variable { (parallaxView, view) -> CGPoint in
                            let progressRatio = (parallaxView.contentSize.width - 3 * parallaxView.contentOffset.x) / parallaxView.contentSize.width
                            return CGPoint(x: 0.65 * progressRatio, y: 0.65 * (1 - progressRatio))
                          }

let view = UIView(frame: CGRect(x: ?, y: ?, width: ?, height: ?))
let item = HorizontalParallaxScrollViewItem(view: view,
                                            originOffset: CGPoint(x: 150, y: 80),
                                            acceleration: dynamicAcceleration,
                                            progress: { (parallaxView, view) in
                                                //...
                                            })
```

- Second, Build a parallaxView.

```swift
let parallaxView = HorizontalParallaxScrollViewBuilder.setOption { (option) in
                        option.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: view.frame.size.height - 100)
                        option.parallaxViewItems = [item] // You can add more items.
                        option.isPagingEnabled = false
                   }.build()
parallaxView.delegate = self //Optional
```

## Requirements

```ruby
Minimum iOS Target : iOS 8.0
```

## Installation

HorizontalParallaxScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'HorizontalParallaxScrollView'
```

## Author

syjdev@gmail.com

## License

HorizontalParallaxScrollView is available under the MIT license. See the LICENSE file for more info.
