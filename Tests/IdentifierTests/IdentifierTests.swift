import XCTest
import Identifier

final class IdentifierTests: XCTestCase {
    func testInitWithUUID() {
        let uuid = UUID()
        let identifier = Identifier<Void>(uuid: uuid)
        XCTAssertEqual(uuid, identifier.uuid)
    }

    func testRandomIdentifier() {
        // Ensure that `.random()` creates a different unique identifier each time it is called.
        let first = Identifier<Void>.random()
        let second = Identifier<Void>.random()
        XCTAssertNotEqual(first, second)
    }
}
