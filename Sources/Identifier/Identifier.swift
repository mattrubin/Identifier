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

extension Identifier: LosslessStringConvertible {
    public init?(_ description: String) {
        guard let uuid = UUID(uuidString: description) else {
            return nil
        }
        self.init(uuid: uuid)
    }

    public var description: String {
        return uuid.uuidString
    }
}

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
