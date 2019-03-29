# Identifier
### Unique, strongly-typed identifiers in Swift.

[![Build Status](https://travis-ci.com/mattrubin/Identifier.svg?branch=develop)](https://travis-ci.com/mattrubin/Identifier)
[![codecov](https://codecov.io/gh/mattrubin/Identifier/branch/develop/graph/badge.svg)](https://codecov.io/gh/mattrubin/Identifier)

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
You can use typed identifiers, which help ensure an ID for a model of one type is neevr accidentally used in place of another:
```swift
struct Comment: Equatable, Codable {
    let postID: Identifier<Post>
    let authorID: Identifier<User>
    let text: String
    let date: Date
}
```
