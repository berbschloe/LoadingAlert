Pod::Spec.new do |s|
    s.name = "LoadingAlert"
    s.version = "1.0.0"
    s.summary = "A simple, fullscreen loading alert modal with an activity indicator."
    s.homepage = "https://github.com/berbschloe/loadingalert"
    s.license = "MIT"
    s.author = "Brandon Erbschloe"
    s.platform = :ios, "11.0"
    s.source = { :git => "https://github.com/berbschloe/loadingalert.git", :tag => s.version.to_s }
    s.source_files = "LoadingAlert/**/*.{h,m,swift}"
    s.swift_version = "5.0"
end
