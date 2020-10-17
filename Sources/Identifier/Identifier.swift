import struct Foundation.UUID

public struct Identifier<T>: Equatable, Hashable, RawRepresentable {
    public let rawValue: UUID

    public init(rawValue: UUID) {
        self.rawValue = rawValue
    }

    public static func random() -> Identifier {
        self.init(rawValue: UUID())
    }
}

// MARK: - String Convertible

extension Identifier: LosslessStringConvertible {
    /// Instantiates an identifier from a string representation.
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
    public init(from decoder: Decoder) throws {
        rawValue = try UUID(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }
}
