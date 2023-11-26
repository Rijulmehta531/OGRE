//import Foundation
//
//struct Quiz: Decodable {
//    var results: [Result]
//
//    struct Result: Decodable, Identifiable {
//        var id: Int
////        var category: String
//        var type: String
//        var difficulty: String
////        var question: String
//        var correct: [String]
//        var answers: [String]?
//        var description: String
//        var descriptionHtml: String
//
//        enum CodingKeys: String, CodingKey {
//            case id,type, difficulty, description,answers,correct
//            case descriptionHtml = "description-html"
//        }
//        init(from decoder: Decoder) throws {
//                    let container = try decoder.container(keyedBy: CodingKeys.self)
//                    id = try container.decode(Int.self, forKey: .id)
//                    type = try container.decode(String.self, forKey: .type)
//                    difficulty = try container.decode(String.self, forKey: .difficulty)
//                    answers = try? container.decode([String].self, forKey: .answers)
//                    description = try container.decode(String.self, forKey: .description)
//                    descriptionHtml = try container.decode(String.self, forKey: .descriptionHtml)
//
//                    // Custom decoding for the `correct` field
//                    if let correctString = try? container.decode(String.self, forKey: .correct) {
//                        correct = [correctString]
//                    } else {
//                        correct = try container.decode([String].self, forKey: .correct)
//                    }
//                }
//        var formattedQuestion: AttributedString {
//            do {
//                return try AttributedString(markdown: description)
//            } catch {
//                print("Error setting formattedQuestion: \(error)")
//                return ""
//            }
//        }
//
//        var cAns: [Answer] {
//            do {
//                let corr = correct.compactMap { answer in
//                    try? Answer(text: AttributedString(markdown: answer), isCorrect: true)
//                }
//                return corr
//            } catch {
//                print("Error setting answers: \(error)")
//                return []
//            }
//        }
//
//        var answers1: [Answer] {
//            do {
//                let allAnswers = try answers?.compactMap { answer -> Answer? in
//                    let trimmedAnswer = answer.trimmingCharacters(in: .whitespacesAndNewlines)
//                    return try? Answer(text: AttributedString(markdown: trimmedAnswer), isCorrect: correct.contains(trimmedAnswer))
//                } ?? []
//
//                return allAnswers.shuffled()
//
//            } catch {
//                print("Error setting answers: \(error)")
//                return []
//            }
//        }
//
//
//
//        
//    }
//}
