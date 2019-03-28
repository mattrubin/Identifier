import struct Foundation.UUID

public struct Identifier<T> {
    public let uuid: UUID

    public init(uuid: UUID) {
        self.uuid = uuid
    }
}
