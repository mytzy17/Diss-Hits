# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Diss-Hits' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Diss-Hits
  pod 'GoogleSignIn'
  pod 'Parse'
  pod 'AlamofireImage'
  pod 'MessageInputBar'

  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end

end
