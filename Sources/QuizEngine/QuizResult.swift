import Foundation

public struct QuizResult <Question: Hashable, Answer> {
    public let answers: [Question: Answer]
    public let score: Int
}
