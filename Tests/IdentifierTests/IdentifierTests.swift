import XCTest
import Identifier

final class IdentifierTests: XCTestCase {
    func testInitWithUUID() {
        let uuid = UUID()
        let identifier = Identifier<Void>(uuid: uuid)
        XCTAssertEqual(uuid, identifier.uuid)
    }
}
