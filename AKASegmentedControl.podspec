Pod::Spec.new do |s|
  s.name     = 'AKASegmentedControl'
  s.version  = '1.0.5'
  s.author   = { 'Ali Karagoz' => 'mail@alikaragoz.net' }
  s.homepage = 'https://github.com/alikaragoz/AKASegmentedControl'
  s.summary  = 'AKASegmentedControl is a fully customizable Segmented Control for iOS.'
  s.source   = { :git => 'https://github.com/alikaragoz/AKASegmentedControl.git', :tag => '1.0.5' }
  s.license  = 'MIT'
  
  s.platform = :ios
  s.source_files = 'AKASegmentedControl'
  s.requires_arc = true
end
