import struct Foundation.UUID

public struct Identifier<T>: Equatable, Hashable {
    public let uuid: UUID

    public init(uuid: UUID) {
        self.uuid = uuid
    }

    public static func random() -> Identifier {
        self.init(uuid: UUID())
    }
}

// MARK: - String Convertible

extension Identifier: LosslessStringConvertible {
    /// Instantiates an identifier from a string representation.
    public init?(_ description: String) {
        guard let uuid = UUID(uuidString: description) else {
            return nil
        }
        self.init(uuid: uuid)
    }

    /// A string representation of this identifier.
    public var description: String {
        uuid.uuidString
    }
}

extension Identifier: CustomDebugStringConvertible {
    /// A detailed string representation of this identifier, for use in debugging.
    public var debugDescription: String {
        "Identifier<\(T.self)>(uuid: \(uuid))"
    }
}

// MARK: - Codable

extension Identifier: Codable {
    public init(from decoder: Decoder) throws {
        uuid = try UUID(from: decoder)
    }

    public func encode(to encoder: Encoder) throws {
        try uuid.encode(to: encoder)
    }
}
