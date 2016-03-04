
Pod::Spec.new do |s|
  s.name          = "Appendix"
  s.version       = "0.0.3"
  s.summary       = "Some Swifty helpers"
  s.description   = "Just some helpers and extensions for Swift."
  s.homepage      = "https://github.com/wess/appendix"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = "Wess Cope"
  s.platform      = :ios, '8.0'
  s.source        = { :git => "https://github.com/wess/appendix.git", :tag => "0.0.3" }
  s.source_files  = "Sources/*.*"
end
