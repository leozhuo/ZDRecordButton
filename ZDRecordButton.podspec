
#
#  Be sure to run `pod spec lint ZDRecordButton.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "ZDRecordButton"
  spec.version      = "0.0.2"
  spec.summary      = "仿微信长钮录制视频和点击拍照的按钮控件."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  # spec.description  = <<-DESC

  spec.homepage     = "https://github.com/leozhuo/ZDRecordButton"


  #spec.license      = "MIT (example)"
  spec.license      = { :type => "MIT", :file => "LICENSE" }


  spec.author             = { "leozhuo" => "1078528010@qq.com" }

  spec.platform     = :ios, "10.0"

  spec.source       = { :git => "https://github.com/leozhuo/ZDRecordButton.git", :tag => "0.0.2" }


  spec.source_files  = "ZDRecordButton/ZDRecord/*.{h,m}"


end
