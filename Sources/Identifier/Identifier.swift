import struct Foundation.UUID

public struct Identifier<T>: Equatable, Hashable {
    public let uuid: UUID

    public init(uuid: UUID) {
        self.uuid = uuid
    }
}
