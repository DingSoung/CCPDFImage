Pod::Spec.new do |s|
  s.name         = "PDFImage"
  s.version      = "1.0.1"
  s.source       = { :git => "https://github.com/DingSoung/PDFImage.git", :tag => "#{s.version}" }
  s.source_files = "PDFImage/*.swift"
  s.dependency  "Extension"
  s.summary      = "no summary"
  s.homepage     = "https://github.com/DingSoung"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Ding Songwen" => "DingSoung@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
end