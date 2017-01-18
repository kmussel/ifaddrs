Pod::Spec.new do |s|
  s.name            = 'Ifaddrs'
  s.version         = '0.0.1'
  s.summary         = 'Swift module map for ifaddrs.'
  s.description     = 'Module maps for importing Ifaddrs C libs to Swift.'
  s.homepage        = 'https://github.com/kmussel/ifaddrs'
  s.license         = { :type => 'Public'}
  s.author          = 'Kevin Musselman'
  s.platform        = :ios, '9.0'
  s.source          = { :git => 'git@github.com:kmussel/ifaddrs.git', tag: "#{s.version}" }
  s.module_name     = 'Ifaddrs'
  s.platforms       = { :ios => "9.0" }
  s.source_files    = "Sources/**/*.swift"
  s.pod_target_xcconfig = { 'SWIFT_ACTIVE_COMPILATION_CONDITIONS[config=Debug][sdk=*][arch=*]' => 'DEBUG' }

  s.xcconfig         = { 'HEADER_SEARCH_PATHS' =>           '$(SDKROOT)/usr/include/ifaddrs.h'}
  s.preserve_paths = 'CocoaPods/**/*'
  s.pod_target_xcconfig = {
    'SWIFT_INCLUDE_PATHS[sdk=macosx*]'           => '$(PODS_ROOT)/Ifaddrs/CocoaPods/macosx',
    'SWIFT_INCLUDE_PATHS[sdk=iphoneos*]'         => '$(PODS_ROOT)/Ifaddrs/CocoaPods/iphoneos',
    'SWIFT_INCLUDE_PATHS[sdk=iphonesimulator*]'  => '$(PODS_ROOT)/Ifaddrs/CocoaPods/iphonesimulator',    
  }
  s.prepare_command = <<-CMD
               ./CocoaPods/injectXcodePath.sh
  CMD
end
