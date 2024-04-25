#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint mogua.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'mogua'
  s.version          = '0.0.1'
  s.summary          = 'Web to App Parameter Passing Solution.'
  s.description      = <<-DESC
Our SDK tracks the parameters of app download links sent via text, email, QR codes, and affiliate pages, enabling precise attribution from download to app launch.
                       DESC
  s.homepage         = 'https://www.mogua.io'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Omnimind' => 'omnimind.sg@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'MoguaSDK', '~> 0.4.4'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
