#if !canImport(ObjectiveC)
import XCTest

extension IdentifierTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__IdentifierTests = [
        ("testDebugDescription", testDebugDescription),
        ("testDecode", testDecode),
        ("testDescription", testDescription),
        ("testEncode", testEncode),
        ("testEquality", testEquality),
        ("testInitWithDescription", testInitWithDescription),
        ("testInitWithRawValue", testInitWithRawValue),
        ("testRandomIdentifier", testRandomIdentifier),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(IdentifierTests.__allTests__IdentifierTests),
    ]
}
#endif
