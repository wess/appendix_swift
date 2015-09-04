
Pod::Spec.new do |s|
  s.name          = "Appendix"
  s.version       = "0.0.1"
  s.summary       = "Some Swifty helpers"
  s.description   = "Just some helpers and extensions for Swift 2.0."
  s.homepage      = "https://github.com/wess/appendix"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = "Wess Cope"
  s.platform      = :ios, '8.0'
  s.source        = { :git => "https://github.com/wess/appendix.git", :tag => "v0.0.1" }
  s.source_files  = "Appendix/*.*"
end
