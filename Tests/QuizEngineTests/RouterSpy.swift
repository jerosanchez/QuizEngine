import Foundation
@testable import QuizEngine

class RouterSpy: Router {
    var routedQuestions: [String] = []
    var routedResult: QuizResult<String, String>? = nil
    var answerCallback: (String) -> Void = { _  in }
    
    func routeTo(question: String, answerCallback: @escaping (String) -> Void) {
        routedQuestions.append(question)
        self.answerCallback = answerCallback
    }
    
    func routeTo(result: QuizResult<String, String>) {
        routedResult = result
    }
}
