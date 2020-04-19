import XCTest
@testable import QuizEngine

final class FlowTests: XCTestCase {
    
    let router = RouterSpy()
        
    func test_start_withNoQuestion_doesNotRouteToQuestion() {
        makeSUT(questions: []).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion() {
        makeSUT(questions: ["Q1"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion() {
        makeSUT(questions: ["Q1", "Q2"]).start()

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_runsTwice_routesToFirstQuestionTwice() {
        let sut = makeSUT(questions: ["Q1", "Q2"])

        sut.start()
        sut.start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstAndSecondQuestion_withThreeQuestions_routesToSecondAndThirdQuestions() {
        let sut = makeSUT(questions: ["Q1", "Q2", "Q3"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2", "Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestions_doesNotRouteToNextQuestion() {
        let sut = makeSUT(questions: ["Q1"])
        sut.start()
        
        router.answerCallback("A1")

        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withNoQuestion_routesToResult() {
        makeSUT(questions: []).start()
        
        XCTAssertEqual(router.routedResult!, [:])
    }
    
    func test_startAndAnswerFirstAndSecondQuestions_withTwoQuestions_routesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        router.answerCallback("A2")

        XCTAssertEqual(router.routedResult, ["Q1": "A1", "Q2": "A2"])
    }
    
    func test_start_withOneQuestions_doesNotRoutesToResult() {
        makeSUT(questions: ["Q1"]).start()

        XCTAssertNil(router.routedResult)
    }
    
    func test_startAndAnswerFirstQuestions_withTwoQuestions_doesNotRoutesToResult() {
        let sut = makeSUT(questions: ["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")

        XCTAssertNil(router.routedResult)
    }
    
    // MARK: - Helpers
    
    private func makeSUT(questions: [String]) -> Flow<String, String, RouterSpy> {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var routedResult: [String: String]? = nil
        var answerCallback: (String) -> Void = { _  in }
        
        func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
        
        func routeTo(result: [String: String]) {
            routedResult = result
        }
    }

    static var allTests = [
        ("test_start_withNoQuestion_doesNotRouteToQuestion", test_start_withNoQuestion_doesNotRouteToQuestion),
    ]
}
