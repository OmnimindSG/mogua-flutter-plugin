#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mogua.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mogua'
  s.version          = '0.0.2'
  s.summary          = 'Web to App Parameter Passing Solution.'
  s.description      = <<-DESC
Web to App Parameter Passing Solution. A lightweight deferred deep linking SDK to track your app's installations from webpages.
                       DESC
  s.homepage         = 'https://www.mogua.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Omnimind' => 'omnimind.sg@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  # The dependency's version and the s.version should be increased at the same time, to make sure that the pod will be publish properly.
  s.dependency 'MoguaSDK', '~> 0.4.4'
  s.static_framework = true
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
