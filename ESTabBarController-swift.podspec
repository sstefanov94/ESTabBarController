Pod::Spec.new do |s|
s.name              = 'ESTabBarController-swift'
s.version           = '2.4'
s.summary           = 'An easy way to customize tabBarController and tabBarItem.'
s.homepage          = 'https://github.com/eggswift/ESTabBarController'

s.license           = { :type => 'MIT', :file => 'LICENSE' }
s.authors           = { 'lihao' => 'lihao_ios@hotmail.com'}
s.social_media_url  = 'https://github.com/eggswift'
s.platform          = :ios, '8.0'
s.source            = {:git => 'https://github.com/sstefanov94/ESTabBarController.git'}
s.source_files      = ['Sources/**/*.{swift}']
s.requires_arc      = true
end
