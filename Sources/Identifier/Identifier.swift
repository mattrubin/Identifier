import struct Foundation.UUID

public struct Identifier<T>: Equatable, Hashable {
    public let uuid: UUID

    public init(uuid: UUID) {
        self.uuid = uuid
    }

    public static func random() -> Identifier {
        return self.init(uuid: UUID())
    }
}

// MARK: - String Convertible

extension Identifier: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "Identifier<\(T.self)>(uuid: \(uuid))"
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
