#
# Be sure to run `pod lib lint CZQLiveKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CZQLiveKit'
  s.version          = '0.1.2'
  s.summary          = 'CZQLiveKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '直播模块 CZQLiveKit'

  s.homepage         = 'https://github.com/IUCoco/CZQLiveKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'IUCoco' => 'czq1157111246@gmail.com' }
  s.source           = { :git => 'https://github.com/IUCoco/CZQLiveKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CZQLiveKit/Classes/**/*.{h,m}'
  
  s.resource_bundles = {
  'CZQLiveKit' => ['CZQLiveKit/Classes/**/*.{storyboard,xib}']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'Socket.IO-Client-Swift'
    s.dependency 'CZQLessonCategoryKit'
    s.dependency 'AFNetworking'
    s.dependency 'MJExtension'
    s.dependency 'SVProgressHUD'
    s.dependency 'LFLiveKit'
    s.dependency 'SDWebImage'
    s.dependency 'IHKeyboardAvoiding'
end
