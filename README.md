# Identifier
### Unique, strongly-typed identifiers in Swift.

[![Build Status](https://travis-ci.com/mattrubin/Identifier.svg?branch=develop)](https://travis-ci.com/mattrubin/Identifier)
[![Codecov](https://img.shields.io/codecov/c/github/mattrubin/Identifier/develop.svg)](https://codecov.io/gh/mattrubin/Identifier)
![Swift 5.0](https://img.shields.io/badge/swift-5.0-orange.svg)
![Available via Carthage, CocoaPods, or SPM](https://img.shields.io/badge/via-Carthage%20%7C%20CocoaPods%20%7C%20SPM-MediumSlateBlue.svg)
![Platforms: iOS, macOS, tvOS, watchOS, Linux](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-blue.svg)
[![MIT License](https://img.shields.io/badge/license-MIT-lightgray.svg)](LICENSE.md)

`Identifier` is a generic struct backed by a UUID, which can be specialized for the model type it identifies and provides unique, decentralized identity in a value type. It is Equatable, Hashable, and Codable, serializing to a simple UUID string.

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

### [Carthage][]

Add the following line to your [Cartfile][]:

````config
github "mattrubin/Identifier" ~> 1.0
````

Then run `carthage update Identifier` to install the latest version of the framework.

Be sure to check the Carthage README file for the latest instructions on [adding frameworks to an application][carthage-instructions].

[Carthage]: https://github.com/Carthage/Carthage
[Cartfile]: https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile
[carthage-instructions]: https://github.com/Carthage/Carthage/blob/master/README.md#adding-frameworks-to-an-application

### [CocoaPods][]

Add the following line to your [Podfile][]:

````ruby
pod 'Identifier', '~> 1.0'
````

Identifier, like all pods written in Swift, can only be integrated as a framework. Make sure to add the line `use_frameworks!` to your Podfile or target to opt into frameworks instead of static libraries.

Then run `pod install` to install the latest version of the framework.

[CocoaPods]: https://cocoapods.org
[Podfile]: https://guides.cocoapods.org/using/the-podfile.html

### [SPM][]

Add the following line to the dependencies section of your [package manifest][Package.swift]:

```swift
.package(url: "https://github.com/mattrubin/Identifier.git", from: "1.0.0"),
```

Then add `"Identifier"` to the dependencies array of any target which should be linked with this library 

[SPM]: https://swift.org/package-manager/
[Package.swift]: https://github.com/apple/swift-package-manager/tree/master/Documentation


## License

Identifier is released under the [MIT License](LICENSE.md).
