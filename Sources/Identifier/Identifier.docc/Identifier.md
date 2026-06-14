# ``Identifier``

Unique, strongly-typed identifiers in Swift.

## Overview

`Identifier` is a generic value type backed by a `UUID`. By specializing it for the model type it identifies, you get
unique, decentralized identity that the compiler can keep type-safe: an identifier for one kind of model can never be
accidentally used in place of an identifier for another.

Instead of using untyped `String` identifiers in your models:

```swift
struct Comment {
    let postID: String
    let authorID: String
}
```

use typed identifiers, which let the compiler catch mismatches for you:

```swift
struct Comment {
    let postID: Identifier<Post>
    let authorID: Identifier<User>
}
```

``Identifier`` is `Equatable`, `Hashable`, `Sendable`, and `Codable`, and serializes to a plain `UUID` string.

## Topics

### Essentials

- <doc:UsingTypedIdentifiers>
- ``Identifier``
