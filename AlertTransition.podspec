Pod::Spec.new do |s|

  s.name         = "AlertTransition"
  s.version      = "2.1.0"
  s.license      = "MIT"
  s.summary      = "AlertTransition is a extensible library for making view controller transitions, especially for alert transitions."

  s.homepage     = "https://github.com/loopeer/AlertTransition"
  s.author       = { "HanShuai" => "hanshuai@loopeer.com" }

  s.source       = { :git => "https://github.com/loopeer/AlertTransition.git", :tag => s.version }

  s.requires_arc = true
  s.ios.deployment_target  = "8.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

  s.subspec 'Core' do |core|
    core.source_files = ['AlertTransition/*.swift']
  end

  s.subspec 'Easy' do |easy|
    easy.source_files = ['AlertTransition/Transitions/EasyTransition/*.swift']
    easy.dependency 'AlertTransition/Core'
  end

  s.subspec 'Menu' do |menu|
    menu.source_files = ['AlertTransition/Transitions/MenuTransition/*.swift']
    menu.dependency 'AlertTransition/Core'
  end

  s.subspec 'Trolley' do |trolley|
    trolley.source_files = ['AlertTransition/Transitions/TrolleyTransition.swift']
    trolley.dependency 'AlertTransition/Core'
  end

# By default install just the Core subspec code
  s.default_subspec = ['Easy']
end
