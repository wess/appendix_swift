
Pod::Spec.new do |s|
  s.name          = "Appendix"
  s.version       = "3.0"
  s.summary       = "Some Swifty helpers"
  s.description   = "Just some helpers and extensions for Swift."
  s.homepage      = "https://github.com/wess/appendix"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = "Wess Cope"
  s.platform      = :ios, '9.0'
  s.source        = { :git => "https://github.com/wess/appendix.git", :tag => s.version.to_s }
  s.source_files  = "Sources/*.swift"
end
