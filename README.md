# SYParallaxScrollView

[![Version](https://img.shields.io/cocoapods/v/SYParallaxScrollView.svg?style=flat)](http://cocoapods.org/pods/SYParallaxScrollView)
[![License](https://img.shields.io/cocoapods/l/SYParallaxScrollView.svg?style=flat)](http://cocoapods.org/pods/SYParallaxScrollView)
[![Platform](https://img.shields.io/cocoapods/p/SYParallaxScrollView.svg?style=flat)](http://cocoapods.org/pods/SYParallaxScrollView)

![Demo Animation](https://imgur.com/3YAkoIS "Demo")


## Usage

- First, You have to define `SYParallaxViewItem` object.

```swift
let view = UIView(...)
let item = SYParallaxViewItem(view: view,
                      originOffset: CGPoint(x: 150, y: 80),
                      acceleration: SYParallaxAcceleration.invariable(CGPoint(x: 1, y: 1)),
                          progress: { (parallaxView, view) in
                                       //...
                                    }
                              )
```

If you want, You can define a dynamic acceleration.

```swift
let dynamicAcceleration = SYParallaxAcceleration.variable { (parallaxView, view) -> CGPoint in
	let progressRatio = (parallaxView.contentSize.width - 3 * parallaxView.contentOffset.x) / parallaxView.contentSize.width
	return CGPoint(x: 0.65 * progressRatio, y: 0.65 * (1 - progressRatio))
}

let view = UIView(...)
let item = SYParallaxViewItem(view: view,
                      originOffset: CGPoint(x: 150, y: 80),
                      acceleration: dynamicAcceleration,
                          progress: { (parallaxView, view) in
                                       //...
                                    }
                              )
```

- Second, Build a parallaxView.

```swift
let parallaxView = SYParallaxScrollViewBuilder.setOption { (option) in
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

SYParallaxScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SYParallaxScrollView'
```

## Author

syjdev@gmail.com

## License

SYParallaxScrollView is available under the MIT license. See the LICENSE file for more info.
