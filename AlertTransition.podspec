Pod::Spec.new do |s|

  s.name         = "AlertTransition"
  s.version      = "1.0.0"
  s.license      = "MIT"
  s.summary      = "AlertTransition is a extensible library for making view controller transitions, especially for alert transitions."

  s.homepage     = "https://github.com/loopeer/AlertTransition"
  s.author       = { "HanShuai" => "hanshuai@loopeer.com" }

  s.source       = { :git => "https://github.com/loopeer/AlertTransition.git", :tag => s.version }

  s.source_files  = ["AlertTransition/*.swift","AlertTransition/Transitions/*.swift","AlertTransition/Transitions/EasyTransition/*.swift","AlertTransition/Transitions/MenuTransition/*.swift","AlertTransition/AlertTransition.h"]
  s.public_header_files = ["AlertTransition/AlertTransition.h"]

  s.requires_arc = true
  s.ios.deployment_target  = "8.0"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }

end
