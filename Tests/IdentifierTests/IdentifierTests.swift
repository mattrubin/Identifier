// SPDX-FileCopyrightText: © 2019-2024 Matt Rubin
// SPDX-License-Identifier: MIT

import Foundation
import Testing

import Identifier

struct IdentifierTests {
    let firstUUID: UUID
    let secondUUID: UUID

    init() throws {
        firstUUID = try #require(UUID(uuidString: "B9212942-B5B9-4547-A994-375921769411"))
        secondUUID = try #require(UUID(uuidString: "1552BA9E-8378-489F-B6BC-E810973931E0"))
    }

    @Test
    func testInitWithRawValue() {
        let uuid = UUID()
        let identifier = Identifier<Void>(rawValue: uuid)
        #expect(uuid == identifier.rawValue)
    }

    @Test
    func testRandomIdentifier() {
        // Ensure that `.random()` creates a different unique identifier each time it is called.
        let first = Identifier<Void>.random()
        let second = Identifier<Void>.random()
        #expect(first != second)
    }

    @Test
    func testEquality() {
        let first = Identifier<Void>(rawValue: firstUUID)
        #expect(first == first) // swiftlint:disable:this identical_operands

        let second = Identifier<Void>(rawValue: secondUUID)
        let secondAgain = Identifier<Void>(rawValue: secondUUID)
        #expect(second == secondAgain)

        #expect(first != second)
        #expect(first != secondAgain)

        let third = Identifier<Void>.random()
        #expect(third == third) // swiftlint:disable:this identical_operands

        let fourth = Identifier<Void>.random()
        #expect(fourth == fourth) // swiftlint:disable:this identical_operands

        #expect(third != fourth)
    }

    // MARK: - String Convertible

    @Test
    func testInitWithDescription() {
        let firstFromUUID = Identifier<Int>(rawValue: firstUUID)
        let firstDescription = "B9212942-B5B9-4547-A994-375921769411"
        let firstFromDescription = Identifier<Int>(firstDescription)
        #expect(firstFromDescription == firstFromUUID)

        let secondRandom = Identifier<String>.random()
        let secondDescription = secondRandom.rawValue.uuidString
        let secondFromDescription = Identifier<String>(secondDescription)
        #expect(secondFromDescription == secondRandom)

        let validDescription = UUID().uuidString
        let validIdentifier = Identifier<Float>(validDescription)
        #expect(validIdentifier != nil)

        let invalidDescription = "12345"
        let invalidIdentifier = Identifier<Float>(invalidDescription)
        #expect(invalidIdentifier == nil)
    }

    @Test
    func testDescription() {
        let first = Identifier<Int>(rawValue: firstUUID)
        let firstExpectedDebugDescription = "B9212942-B5B9-4547-A994-375921769411"
        #expect(first.description == firstExpectedDebugDescription)

        let second = Identifier<String>.random()
        let secondExpectedDebugDescription = second.rawValue.uuidString
        #expect(second.description == secondExpectedDebugDescription)
    }

    @Test
    func testDebugDescription() {
        let first = Identifier<Int>(rawValue: firstUUID)
        let firstExpectedDebugDescription = "Identifier<Int>(rawValue: B9212942-B5B9-4547-A994-375921769411)"
        #expect(first.debugDescription == firstExpectedDebugDescription)

        let second = Identifier<String>.random()
        let secondExpectedDebugDescription = "Identifier<String>(rawValue: " + second.rawValue.uuidString + ")"
        #expect(second.debugDescription == secondExpectedDebugDescription)
    }

    // MARK: - Codable

    @Test
    func testEncode() throws {
        let uuid = try #require(UUID(uuidString: "a80c0fdf-c1fe-4023-8ba3-dd1ad9b3cb94"))
        let expectedJSON = Data("[\"A80C0FDF-C1FE-4023-8BA3-DD1AD9B3CB94\"]".utf8)

        let identifier = Identifier<Void>(rawValue: uuid)

        let encoder = JSONEncoder()
        #expect(try encoder.encode(JSONFragmentEncodingWrapper(identifier)) == expectedJSON)
    }

    @Test
    func testDecode() throws {
        let uuid = try #require(UUID(uuidString: "3b46cdce-a7d1-424a-ad2c-99fcd200f1a2"))
        let json = Data("[\"3B46CDCE-A7D1-424A-AD2C-99FCD200F1A2\"]".utf8)

        let decoder = JSONDecoder()
        #expect(
            try decoder.decode(JSONFragmentEncodingWrapper<Identifier<Void>>.self, from: json).value ==
            Identifier(rawValue: uuid))

        let emptyJSON = Data()
        #expect(throws: DecodingError.self) {
            try decoder.decode(JSONFragmentEncodingWrapper<Identifier<Void>>.self, from: emptyJSON).value
        }

        let badStringJSON = Data("[\"3B46CDCE\"]".utf8)
        #expect(throws: DecodingError.self) {
            try decoder.decode(JSONFragmentEncodingWrapper<Identifier<Void>>.self, from: badStringJSON).value
        }
    }

    // MARK: - Sendable

    /// This test will fail to compile if `Identifier` does not conform to `Sendable`.
    @Test
    func testSendable() async {
        actor IdentifierProducer {
            func makeIdentifier<T>() -> Identifier<T> {
                Identifier.random()
            }
        }

        let producer = IdentifierProducer()
        let identifier: Identifier<Void> = await producer.makeIdentifier()

        #expect(identifier == identifier) // swiftlint:disable:this identical_operands
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
