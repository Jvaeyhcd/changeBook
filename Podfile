platform :ios, '8.0'
source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
target 'changeBook' do

    # swift3.0
    pod 'SnapKit', '~> 3.2.0'
    pod 'SwiftyJSON', '~> 3.1.4'
    pod 'RxSwift', '~> 3.3.1'
    pod 'RxCocoa', '~> 3.3.1'
    pod 'ObjectMapper', '~> 2.2.5'
    pod 'Moya/RxSwift'
    pod 'NVActivityIndicatorView', '~> 3.6.0'
    pod 'RealmSwift', '~> 2.5.1'
    pod 'SQLite.swift'

    # objective-c
    pod 'SDWebImage', '~> 3.8.2'
    pod 'SDWebImage/WebP'
    pod 'Shimmer', '~> 1.0.2'
    pod 'iVersion', '~> 1.11.4'
    pod 'WordPress-iOS-Editor-Extension', '~> 0.1.5'
    pod 'HCSStarRatingView', '~> 1.4.5'
    pod 'NJKWebViewProgress', '~> 0.2.3'
    pod 'HcdActionSheet', '~> 0.0.1'
    pod 'VWProgressHUD'
    pod 'ReachabilitySwift'
    pod 'UMengAnalytics-NO-IDFA'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
