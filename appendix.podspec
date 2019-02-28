
Pod::Spec.new do |s|
  s.name          = "Appendix"
  s.version       = "3.0"
  s.summary       = "Some Swifty helpers"
  s.description   = "Just some helpers and extensions for Swift."
  s.homepage      = "https://github.com/wess/appendix"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = "Wess Cope"
  s.source        = { :git => "https://github.com/wess/appendix.git", :tag => s.version.to_s }
  s.swift_version = '4.2'
  s.requires_arc  = true

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.13'


  s.ios.source_files  = ["Sources/shared/*.swift", "Sources/shared/**/*.swift", "Sources/ios/*.swift", "Sources/ios/**/*.swift"]
  s.osx.source_files  = ["Sources/shared/*.swift", "Sources/shared/**/*.swift", "Sources/macos/*.swift", "Sources/macos/**/*.swift"]
end
