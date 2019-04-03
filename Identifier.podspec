Pod::Spec.new do |spec|
  spec.name         = "Identifier"
  spec.version      = "1.0.0"
  spec.summary      = "Unique, strongly-typed identifiers in Swift."
  spec.description  = "`Identifier` is a generic struct backed by a UUID, which can be specialized for the model type it identifies and provides unique, decentralized identity in a value type. It is Equatable, Hashable, and Codable, serializing to a simple UUID string."
  spec.homepage     = "https://github.com/mattrubin/Identifier"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author       = "Matt Rubin"

  spec.source         = { :git => "https://github.com/mattrubin/Identifier.git", :tag => "#{spec.version}" }
  spec.source_files   = "Sources/Identifier/**/*.swift"
  spec.frameworks     = "Foundation"
  spec.swift_version  = "5.0"

  spec.ios.deployment_target      = "8.0"
  spec.osx.deployment_target      = "10.10"
  spec.tvos.deployment_target     = "9.0"
  spec.watchos.deployment_target  = "2.0"
end
