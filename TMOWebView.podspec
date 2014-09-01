Pod::Spec.new do |s|
  s.name         = "TMOWebView"
  s.version      = "0.0.1"
  s.summary      = "TMOWebView is a replacement of WebViewJavascriptBridge."
  s.description  = <<-DESC
                   TMOWebView is a replacement of WebViewJavascriptBridge, provide javascript extension, callback.
                   DESC
  s.homepage     = "https://github.com/duowan/TMOWebView/"
  s.license      = "MIT"
  s.author             = { "PonyCui" => "cuiminghui@yy.com" }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/duowan/TMOWebView.git", :tag => "0.0.1" }
  s.source_files  = "Src", "Src/*.{h,m}"
  s.resources = "Src/*.js"
  s.requires_arc = true

end
