import Foundation

public struct Game<Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    let flow: Flow<Question, Answer, R>
}

public func startGame<Question, Answer: Equatable, R: Router> (questions: [Question], router: R, correctAnswers: [Question: Answer]) -> Game<Question, Answer, R> where R.Question == Question, R.Answer == Answer {
    let flow = Flow(questions: questions, router: router, scoring: {
        scoring($0, correctAnswers: correctAnswers)
    })
    flow.start()
    return Game(flow: flow)
}

// MARK: - Helpers

private func scoring<Question: Hashable, Answer: Equatable>(_ answers: [Question: Answer], correctAnswers: [Question: Answer]) -> Int {
    return answers.reduce(0) { (score, answer) in
        return score + (correctAnswers[answer.key] == answer.value ? 1 : 0)
    }
}
