# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
platform :ios, '13.2'
use_frameworks!

target 'homework' do
  pod 'Auth0', '~> 1.19'
  pod "PromiseKit", "~> 6.8"
end

target 'Data' do
  pod 'Auth0', '~> 1.19'
  pod "PromiseKit", "~> 6.8"

  target 'DataTests' do
    inherit! :search_paths
  end
end

target 'Domain' do
	pod "PromiseKit", "~> 6.8"

	target 'DomainTests' do
    inherit! :search_paths
  end
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.2'
      end
    end
end