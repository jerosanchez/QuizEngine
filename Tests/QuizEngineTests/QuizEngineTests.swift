import XCTest
@testable import QuizEngine

final class QuizEngineTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(QuizEngine().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
