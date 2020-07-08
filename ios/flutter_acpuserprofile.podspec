#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_acpuserprofile.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_acpuserprofile'
  s.version          = '1.0.0'
  s.summary          = 'Adobe Experience Platform User Profile support for Flutter apps.'
  s.homepage      = 'https://aep-sdks.gitbook.io/docs/'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'Adobe Mobile SDK Team'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'ACPUserProfile'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  # s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
end
