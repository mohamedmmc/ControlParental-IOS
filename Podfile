# Uncomment the next line to define a global platform for your project
  platform :ios, '14.0'

project 'mini_projet.xcodeproj'

target 'mini_projet' do
  # Comment the next line if you don't want to use dynamic frameworks
use_frameworks!
  pod 'GetStreamActivityFeed'
  pod 'GoogleSignIn'

 pod 'SendBirdUIKit' 
  # Pods for mini_projet
  pod 'Alamofire'
pod 'lottie-ios'
pod 'SendBirdSDK'
pod 'Kingfisher'
post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
end
