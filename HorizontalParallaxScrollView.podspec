#
# Be sure to run `pod lib lint HorizontalParallaxScrollView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HorizontalParallaxScrollView'
  s.version          = '0.2.1'
  s.summary          = 'Helpful UI Component for configure Horizontal Parallax Effect.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Using HorizontalParallaxScrollView is an one of wonderful way that configure Horizontal Parallax UI. I will welcome your feedback.'

  s.homepage         = 'https://github.com/syjdev/HorizontalParallaxScrollView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'syjdev' => 'syjdev@gmail.com' }
  s.source           = { :git => 'https://github.com/syjdev/HorizontalParallaxScrollView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.source_files = 'HorizontalParallaxScrollView/Classes/*'
  s.ios.deployment_target = '8.0'

  
  
  # s.resource_bundles = {
  #   'HorizontalParallaxScrollView' => ['HorizontalParallaxScrollView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
