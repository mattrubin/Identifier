import XCTest
import Identifier

// swiftlint:disable force_unwrapping

let firstUUID = UUID(uuidString: "B9212942-B5B9-4547-A994-375921769411")!
let secondUUID = UUID(uuidString: "1552BA9E-8378-489F-B6BC-E810973931E0")!

final class IdentifierTests: XCTestCase {
    func testInitWithRawValue() {
        let uuid = UUID()
        let identifier = Identifier<Void>(rawValue: uuid)
        XCTAssertEqual(uuid, identifier.rawValue)
    }

    func testRandomIdentifier() {
        // Ensure that `.random()` creates a different unique identifier each time it is called.
        let first = Identifier<Void>.random()
        let second = Identifier<Void>.random()
        XCTAssertNotEqual(first, second)
    }

    func testEquality() {
        let first = Identifier<Void>(rawValue: firstUUID)
        XCTAssertEqual(first, first)

        let second = Identifier<Void>(rawValue: secondUUID)
        let secondAgain = Identifier<Void>(rawValue: secondUUID)
        XCTAssertEqual(second, secondAgain)

        XCTAssertNotEqual(first, second)
        XCTAssertNotEqual(first, secondAgain)

        let third = Identifier<Void>.random()
        XCTAssertEqual(third, third)

        let fourth = Identifier<Void>.random()
        XCTAssertEqual(fourth, fourth)

        XCTAssertNotEqual(third, fourth)
    }

    // MARK: - String Convertible

    func testInitWithDescription() {
        let firstFromUUID = Identifier<Int>(rawValue: firstUUID)
        let firstDescription = "B9212942-B5B9-4547-A994-375921769411"
        let firstFromDescription = Identifier<Int>(firstDescription)
        XCTAssertEqual(firstFromDescription, firstFromUUID)

        let secondRandom = Identifier<String>.random()
        let secondDescription = secondRandom.rawValue.uuidString
        let secondFromDescription = Identifier<String>(secondDescription)
        XCTAssertEqual(secondFromDescription, secondRandom)

        let validDescription = UUID().uuidString
        let validIdentifier = Identifier<Float>(validDescription)
        XCTAssertNotNil(validIdentifier)

        let invalidDescription = "12345"
        let invalidIdentifier = Identifier<Float>(invalidDescription)
        XCTAssertNil(invalidIdentifier)
    }

    func testDescription() {
        let first = Identifier<Int>(rawValue: firstUUID)
        let firstExpectedDebugDescription = "B9212942-B5B9-4547-A994-375921769411"
        XCTAssertEqual(first.description, firstExpectedDebugDescription)

        let second = Identifier<String>.random()
        let secondExpectedDebugDescription = second.rawValue.uuidString
        XCTAssertEqual(second.description, secondExpectedDebugDescription)
    }

    func testDebugDescription() {
        let first = Identifier<Int>(rawValue: firstUUID)
        let firstExpectedDebugDescription = "Identifier<Int>(rawValue: B9212942-B5B9-4547-A994-375921769411)"
        XCTAssertEqual(first.debugDescription, firstExpectedDebugDescription)

        let second = Identifier<String>.random()
        let secondExpectedDebugDescription = "Identifier<String>(rawValue: " + second.rawValue.uuidString + ")"
        XCTAssertEqual(second.debugDescription, secondExpectedDebugDescription)
    }

    // MARK: - Codable

    func testEncode() {
        let uuid = UUID(uuidString: "a80c0fdf-c1fe-4023-8ba3-dd1ad9b3cb94")!
        let expectedJSON = "[\"A80C0FDF-C1FE-4023-8BA3-DD1AD9B3CB94\"]".data(using: .utf8)!

        let identifier = Identifier<Void>(rawValue: uuid)

        let encoder = JSONEncoder()
        XCTAssertEqual(try encoder.encode(JSONFragmentEncodingWrapper(identifier)), expectedJSON)
    }

    func testDecode() {
        let uuid = UUID(uuidString: "3b46cdce-a7d1-424a-ad2c-99fcd200f1a2")!
        let json = "[\"3B46CDCE-A7D1-424A-AD2C-99FCD200F1A2\"]".data(using: .utf8)!

        let decoder = JSONDecoder()
        XCTAssertEqual(
            try decoder.decode(JSONFragmentEncodingWrapper<Identifier<Void>>.self, from: json).value,
            Identifier(rawValue: uuid))

        let emptyJSON = Data()
        XCTAssertThrowsError(
            try decoder.decode(JSONFragmentEncodingWrapper<Identifier<Void>>.self, from: emptyJSON).value)

        let badStringJSON = "[\"3B46CDCE\"]".data(using: .utf8)!
        XCTAssertThrowsError(
            try decoder.decode(JSONFragmentEncodingWrapper<Identifier<Void>>.self, from: badStringJSON).value)
    }
}

// This wrapper is necessary because JSONEncoder currently can't handle data that encodes to a top-level JSON fragment.
private struct JSONFragmentEncodingWrapper<T: Codable>: Codable {
    let value: T

    init(_ value: T) {
        self.value = value
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(value)
    }

    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        value = try container.decode(T.self)
    }
}
