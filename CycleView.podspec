#
#  Be sure to run `pod spec lint CycleView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "CycleView"
  s.version      = "1.0.1"
  s.summary      = "a cycleView for app"
  s.author       = { "gaozhihong" => "291305571@qq.com" }
  s.description  = "cycleview for you app"
  s.homepage     = "https://github.com/gaozhihong/CycleView"
  s.license      = {:type => "MIT",:file => "LICENSE"}
   s.platform     = :ios
  s.source       = { :git => "https://github.com/gaozhihong/CycleView.git", :tag => "#{s.version}" }

  s.source_files  = "CycleView/*"
  #s.exclude_files = "Classes/Exclude"


end
