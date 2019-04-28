#
# Be sure to run `pod lib lint BaleMediaPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BaleMediaPicker'
  s.version          = '0.1.6'
  s.summary          = 'this is a simple Gallery Media Picker for iOS applications'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a simple Gallery Media Picker for iOS applications. written in swift.
                       DESC

  s.homepage         = 'https://github.com/rajabpour/BaleMediaPicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors        = { 'masoudrajabpour' => 'masoudrajabpour@gmail.com' , 'mahdiTarighat'=>'mmtarighat@gmail.com'}
  s.source           = { :git => 'https://github.com/rajabpour/BaleMediaPicker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version = '4.0'
  s.source_files = 'BaleMediaPicker/Classes/**/*.swift'
  s.resources = 'BaleMediaPicker/Assets/**/*'

  # s.resource_bundles = {
  #   'BaleMediaPicker' => ['BaleMediaPicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
