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
