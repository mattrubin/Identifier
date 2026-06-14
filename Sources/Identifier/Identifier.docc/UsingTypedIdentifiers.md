# Using Typed Identifiers

Create, convert, and serialize strongly-typed identifiers.

## Overview

An ``Identifier`` is parameterized by the model type it identifies. The type parameter is a *phantom type*: it exists
only at compile time to distinguish one kind of identifier from another, and has no effect on the stored value, which is
always a `UUID`.

### Creating identifiers

Generate a fresh, unique identifier with ``Identifier/random()``:

```swift
let userID = Identifier<User>.random()
```

Or wrap an existing `UUID` with ``Identifier/init(rawValue:)``:

```swift
let id = Identifier<User>(rawValue: someUUID)
```

### Converting to and from strings

``Identifier`` conforms to `LosslessStringConvertible`. Its ``Identifier/description`` is the underlying `UUID` string,
and ``Identifier/init(_:)`` parses that representation back, returning `nil` for invalid input:

```swift
let id = Identifier<User>.random()
let string = id.description                  // e.g. "B9212942-B5B9-4547-A994-375921769411"
let restored = Identifier<User>(string)      // Identifier<User>?
```

### Encoding and decoding

``Identifier`` is `Codable` and encodes as a bare `UUID` string, so it serializes exactly as a `UUID` would:

```swift
struct Comment: Codable {
    let postID: Identifier<Post>
    let authorID: Identifier<User>
}
```

### Type safety

Because each identifier carries its model type, the compiler rejects mismatched assignments:

```swift
let postID = Identifier<Post>.random()
let authorID: Identifier<User> = postID   // ❌ Compile-time error
```

## Topics

### Creating identifiers

- ``Identifier/init(rawValue:)``
- ``Identifier/random()``

### Converting strings

- ``Identifier/init(_:)``
- ``Identifier/description``

### Inspecting identifiers

- ``Identifier/rawValue``
- ``Identifier/debugDescription``
