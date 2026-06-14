// SPDX-FileCopyrightText: © 2019-2024 Matt Rubin
// SPDX-License-Identifier: MIT

import struct Foundation.UUID

/// A unique, strongly-typed identifier backed by a `UUID`.
///
/// `Identifier` is a value type that provides decentralized, universally-unique identity. Its generic parameter `T`
/// is a phantom type that ties an identifier to the kind of model it identifies, so that an identifier for one type of
/// model can never be accidentally used in place of an identifier for another:
///
/// ```swift
/// struct Comment {
///     let postID: Identifier<Post>
///     let authorID: Identifier<User>
/// }
/// ```
///
/// Here, `postID` and `authorID` are both backed by `UUID`, but the compiler treats them as distinct types and will
/// reject any attempt to assign one where the other is expected.
///
/// `Identifier` is `Equatable`, `Hashable`, `Sendable`, and `Codable`, and serializes to a plain `UUID` string.
public struct Identifier<T>: Equatable, Hashable, RawRepresentable, Sendable {
    /// The `UUID` value that backs this identifier.
    public let rawValue: UUID

    /// Creates an identifier that wraps the given `UUID`.
    ///
    /// - Parameter rawValue: The `UUID` to use as the identifier's underlying value.
    public init(rawValue: UUID) {
        self.rawValue = rawValue
    }

    /// Creates a new identifier backed by a randomly-generated `UUID`.
    ///
    /// Each call returns a distinct identifier.
    ///
    /// - Returns: A new, unique identifier.
    public static func random() -> Self {
        self.init(rawValue: UUID())
    }
}

// MARK: - String Convertible

extension Identifier: LosslessStringConvertible {
    /// Creates an identifier from its string representation.
    ///
    /// - Parameter description: A `UUID` string, such as the value returned by ``description``. Returns `nil` if the
    ///   string is not a valid `UUID`.
    public init?(_ description: String) {
        guard let uuid = UUID(uuidString: description) else {
            return nil
        }
        self.init(rawValue: uuid)
    }

    /// A string representation of this identifier.
    public var description: String {
        rawValue.uuidString
    }
}

extension Identifier: CustomDebugStringConvertible {
    /// A detailed string representation of this identifier, for use in debugging.
    public var debugDescription: String {
        "Identifier<\(T.self)>(rawValue: \(rawValue))"
    }
}

// MARK: - Codable

extension Identifier: Codable {
    /// Creates an identifier by decoding a `UUID` from the given decoder.
    ///
    /// - Parameter decoder: The decoder to read the underlying `UUID` from.
    public init(from decoder: Decoder) throws {
        rawValue = try UUID(from: decoder)
    }

    /// Encodes this identifier into the given encoder as its underlying `UUID`.
    ///
    /// - Parameter encoder: The encoder to write the underlying `UUID` to.
    public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }
}
