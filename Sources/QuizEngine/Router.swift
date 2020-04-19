import Foundation

public protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    typealias AnswerCallback = (Answer) -> Void
    
    func routeTo(question: Question, answerCallback: @escaping AnswerCallback)
    func routeTo(result: QuizResult<Question, Answer>)
}
