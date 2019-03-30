import XCTest
import Identifier

let firstUUID = UUID(uuidString: "B9212942-B5B9-4547-A994-375921769411")!
let secondUUID = UUID(uuidString: "1552BA9E-8378-489F-B6BC-E810973931E0")!

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

    func testEquality() {
        let first = Identifier<Void>(uuid: firstUUID)
        XCTAssertEqual(first, first)

        let second = Identifier<Void>(uuid: secondUUID)
        let secondAgain = Identifier<Void>(uuid: secondUUID)
        XCTAssertEqual(second, secondAgain)

        XCTAssertNotEqual(first, second)
        XCTAssertNotEqual(first, secondAgain)

        let third = Identifier<Void>.random()
        XCTAssertEqual(third, third)

        let fourth = Identifier<Void>.random()
        XCTAssertEqual(fourth, fourth)

        XCTAssertNotEqual(third, fourth)
    }
}
