# Identifier
### Unique, strongly-typed identifiers in Swift.

[![Xcode CI status](https://github.com/mattrubin/Identifier/actions/workflows/xcode.yml/badge.svg?branch=develop)](https://github.com/mattrubin/Identifier/actions/workflows/xcode.yml)
[![SPM CI status](https://github.com/mattrubin/Identifier/actions/workflows/spm.yml/badge.svg?branch=develop)](https://github.com/mattrubin/Identifier/actions/workflows/spm.yml)
[![Code Coverage](https://img.shields.io/codecov/c/github/mattrubin/Identifier/develop.svg)](https://codecov.io/gh/mattrubin/Identifier)
[![Swift Version Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmattrubin%2FIdentifier%2Fbadge%3Ftype%3Dswift-versions&color=orange&logo=none)](https://swiftpackageindex.com/mattrubin/Identifier)
[![Supported Platforms](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fmattrubin%2FIdentifier%2Fbadge%3Ftype%3Dplatforms&logo=none)](https://swiftpackageindex.com/mattrubin/Identifier)
[![MIT License](https://img.shields.io/badge/license-MIT-lightgray.svg)](LICENSE.md)

`Identifier` is a generic struct backed by a UUID, which can be specialized for the model type it identifies and provides unique, decentralized identity in a value type. It is Equatable, Hashable, Sendable, and Codable, serializing to a simple UUID string.

Instead of using string identifiers in your models:
```swift
struct Comment: Equatable, Codable {
    let postID: String
    let authorID: String
    let text: String
    let date: Date
}
```

You can use typed identifiers, which help ensure an ID for a model of one type is never accidentally used in place of another:
```swift
struct Comment: Equatable, Codable {
    let postID: Identifier<Post>
    let authorID: Identifier<User>
    let text: String
    let date: Date
}
```


## Installation

### [SPM][]

Add the following line to the dependencies section of your [package manifest][Package.swift]:

```swift
.package(url: "https://github.com/mattrubin/Identifier.git", from: "2.0.0"),
```

Then add `"Identifier"` to the dependencies array of any target which should be linked with this library.

[SPM]: https://swift.org/package-manager/
[Package.swift]: https://github.com/swiftlang/swift-package-manager/tree/main/Documentation


## Documentation

API documentation is available on the [Swift Package Index](https://swiftpackageindex.com/mattrubin/Identifier/documentation).


## License

Identifier is released under the [MIT License](LICENSE.md).
