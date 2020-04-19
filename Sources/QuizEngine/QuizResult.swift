import Foundation

struct QuizResult <Question: Hashable, Answer> {
    let answers: [Question: Answer]
    let score: Int
}
