//
//  UserDataManager.swift
//  ogre
//
//  Created by Aaron Grizzle on 11/21/23.
//

import Firebase

class UserDataManager {
    
    static func getUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func getUserEmail() -> String {
        return Auth.auth().currentUser?.email ?? ""
    }
    
    static func readUserData(userId: String, element: String, completion: @escaping (Any?) -> Void) {
        guard !userId.isEmpty, !element.isEmpty else {
            print("Error: userId and elementName must not be empty.")
            completion(nil)
            return
        }
        let ref = Database.database().reference().child("users").child(userId).child(element)
        ref.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                completion(snapshot.value)
            } else {
                print("Error: \(userId)/\(element) not found.")
                completion(nil)
            }
        }
    }
    
    static func writeUserData(userId: String, element: String, value: Any) {
        guard !userId.isEmpty, !element.isEmpty else {
            print("Error: userId and elementName must not be empty.")
            return
        }
        Database.database().reference().child("users").child(userId).child(element).setValue(value)
    }
    
    static func pushUserData(userId: String, element: String, value: Any) {
        guard !userId.isEmpty, !element.isEmpty else {
            print("Error: userId and elementName must not be empty.")
            return
        }
        let ref = Database.database().reference().child("users").child(userId).child(element)
        if let key = ref.childByAutoId().key {
            ref.child(key).setValue(value)
        }
    }
    
    static func initializeUserData() {
        if let currentUser = Auth.auth().currentUser {
            let userId = currentUser.uid
            let email = currentUser.email ?? ""
            let ref = Database.database().reference().child("all-users")
            ref.observeSingleEvent(of: .value) { snapshot in
                if let users = snapshot.value as? [String: String] {
                    if !users.keys.contains(userId) {
                        Database.database().reference().child("all-users").child(userId).setValue(email)
                        writeUserData(userId: userId, element: "dailyStreak", value: 0)
                        writeUserData(userId: userId, element: "tokens", value: 0)
                        writeUserData(userId: userId, element: "isPremiumMember", value: false)
                        writeUserData(userId: userId, element: "soundEnabled", value: true)
                        let difficulties: [String: [String: Int]] = [
                            "QrEasy": ["answeredCorrectly": 0, "attempted": 0],
                            "QrMedium": ["answeredCorrectly": 0, "attempted": 0],
                            "QrHard": ["answeredCorrectly": 0, "attempted": 0],
                            "QrVeryHard": ["answeredCorrectly": 0, "attempted": 0],
                            "VrEasy": ["answeredCorrectly": 0, "attempted": 0],
                            "VrMedium": ["answeredCorrectly": 0, "attempted": 0],
                            "VrHard": ["answeredCorrectly": 0, "attempted": 0],
                            "VrVeryHard": ["answeredCorrectly": 0, "attempted": 0]
                        ]
                        writeUserData(userId: userId, element: "difficulties", value: difficulties)
                        let subjects: [String: [String: Int]] = [
                            "Algebra": ["answeredCorrectly": 0, "attempted": 0],
                            "Arithmetic and Fractions": ["answeredCorrectly": 0, "attempted": 0],
                            "Backsolving and Plugging": ["answeredCorrectly": 0, "attempted": 0],
                            "Calculator": ["answeredCorrectly": 0, "attempted": 0],
                            "Coordinate Geometry": ["answeredCorrectly": 0, "attempted": 0],
                            "Coordinate Plane": ["answeredCorrectly": 0, "attempted": 0],
                            "Counting": ["answeredCorrectly": 0, "attempted": 0],
                            "Data Interpretation": ["answeredCorrectly": 0, "attempted": 0],
                            "Exponents and Roots": ["answeredCorrectly": 0, "attempted": 0],
                            "Geometry": ["answeredCorrectly": 0, "attempted": 0],
                            "Inequalities": ["answeredCorrectly": 0, "attempted": 0],
                            "Integer Properties": ["answeredCorrectly": 0, "attempted": 0],
                            "Number Sense": ["answeredCorrectly": 0, "attempted": 0],
                            "Percents and Ratios": ["answeredCorrectly": 0, "attempted": 0],
                            "Permutations and Combinations": ["answeredCorrectly": 0, "attempted": 0],
                            "Powers and Roots": ["answeredCorrectly": 0, "attempted": 0],
                            "Probability": ["answeredCorrectly": 0, "attempted": 0],
                            "Quantitative Comparison": ["answeredCorrectly": 0, "attempted": 0],
                            "Statistics": ["answeredCorrectly": 0, "attempted": 0],
                            "Word Problems": ["answeredCorrectly": 0, "attempted": 0],
                            "Basic Sentences": ["answeredCorrectly": 0, "attempted": 0],
                            "Dense and Complex Passages": ["answeredCorrectly": 0, "attempted": 0],
                            "Detail": ["answeredCorrectly": 0, "attempted": 0],
                            "Difficult Sentences": ["answeredCorrectly": 0, "attempted": 0],
                            "Double Blanks": ["answeredCorrectly": 0, "attempted": 0],
                            "Function": ["answeredCorrectly": 0, "attempted": 0],
                            "General Skills": ["answeredCorrectly": 0, "attempted": 0],
                            "Humanities Passages": ["answeredCorrectly": 0, "attempted": 0],
                            "Inference": ["answeredCorrectly": 0, "attempted": 0],
                            "Long Passages": ["answeredCorrectly": 0, "attempted": 0],
                            "Main Idea": ["answeredCorrectly": 0, "attempted": 0],
                            "Medium Passages": ["answeredCorrectly": 0, "attempted": 0],
                            "Multiple Answer": ["answeredCorrectly": 0, "attempted": 0],
                            "Multiple Viewpoints": ["answeredCorrectly": 0, "attempted": 0],
                            "No Shift Sentences": ["answeredCorrectly": 0, "attempted": 0],
                            "Paragraph Argument": ["answeredCorrectly": 0, "attempted": 0],
                            "Paragraph Arguments": ["answeredCorrectly": 0, "attempted": 0],
                            "Pseudo-synonyms": ["answeredCorrectly": 0, "attempted": 0],
                            "Science Passages": ["answeredCorrectly": 0, "attempted": 0],
                            "Select the Sentence": ["answeredCorrectly": 0, "attempted": 0],
                            "Sentence Equivalence": ["answeredCorrectly": 0, "attempted": 0],
                            "Shift Sentences": ["answeredCorrectly": 0, "attempted": 0],
                            "Short Passages": ["answeredCorrectly": 0, "attempted": 0],
                            "Single Viewpoint": ["answeredCorrectly": 0, "attempted": 0],
                            "Tough Vocabulary": ["answeredCorrectly": 0, "attempted": 0],
                            "Triple Blanks": ["answeredCorrectly": 0, "attempted": 0],
                            "Turn": ["answeredCorrectly": 0, "attempted": 0],
                            "Vocabulary in Context": ["answeredCorrectly": 0, "attempted": 0]
                        ]
                        writeUserData(userId: userId, element: "subjects", value: subjects)
                        let eligibleQR: [Int] = Array(0...872)
                        writeUserData(userId: userId, element: "eligibleQR", value: eligibleQR)
                        let eligibleVR: [Int] = Array(0...460)
                        writeUserData(userId: userId, element: "eligibleVR", value: eligibleVR)
                    }
                }
            }
        }
    }
    
    static func getEligibleQuestion(category: String, completion: @escaping (Int) -> Void) {
        var element: String
        if category == "quantitative-reasoning" {
            element = "eligibleQR"
        } else if category == "verbal-reasoning" {
            element = "eligibleVR"
        } else {
            print("Invalid category")
            return
        }
        readUserData(userId: getUserId(), element: element) { snapshot in
            let questions = (snapshot as? [Int?])?.compactMap { $0 } ?? []
            let questionId = questions.randomElement() ?? 0
            completion(questionId)
        }
    }
    
    static func answeredQuestion(questionId: Int, category: String, correct: Bool) {
        
        let userId = getUserId()
        
        // Get question data.
        let ref = Database.database().reference().child("question-data").child(category).child("\(questionId)")
        ref.observeSingleEvent(of: .value) { snapshot, _ in
            let questionData = snapshot.value as? [String: Any] ?? [:]
            let difficulty = questionData["difficulty"] as? String ?? ""
            let subjects = questionData["subject"] as? [String] ?? []
            
            // Get the incorrectly answered questions.
            let ref = Database.database().reference().child("users").child(userId).child("answeredIncorrectly")
            ref.observeSingleEvent(of: .value) { snapshot, _ in
                let answeredIncorrectly = snapshot.value as? [String: Int] ?? [:]
                
                var catDiff: String = ""
                var catEligible: String = ""
                if category == "quantitative-reasoning" {
                    catEligible = "eligibleQR"
                    if difficulty == "Easy" {
                        catDiff = "QrEasy"
                    } else if difficulty == "Medium" {
                        catDiff = "QrMedium"
                    } else if difficulty == "Hard" {
                        catDiff = "QrHard"
                    } else if difficulty == "Very Hard" {
                        catDiff = "QrVeryHard"
                    }
                } else if category == "verbal-reasoning" {
                    catEligible = "eligibleVR"
                    if difficulty == "Easy" {
                        catDiff = "VrEasy"
                    } else if difficulty == "Medium" {
                        catDiff = "VrMedium"
                    } else if difficulty == "Hard" {
                        catDiff = "VrHard"
                    } else if difficulty == "Very Hard" {
                        catDiff = "VrVeryHard"
                    }
                }
                
                // Update stats if not yet answered incorrectly.
                let previouslyIncorrect = answeredIncorrectly.contains { $0.value == questionId }
                if !previouslyIncorrect {
                    readUserData(userId: userId, element: "difficulties/\(catDiff)/attempted") { attempted in
                        let attempted = attempted as? Int ?? 0
                        writeUserData(userId: userId, element: "difficulties/\(catDiff)/attempted", value: attempted + 1)
                    }
                    for subject in subjects {
                        readUserData(userId: userId, element: "subjects/\(subject)/attempted") { attempted in
                            let attempted = attempted as? Int ?? 0
                            writeUserData(userId: userId, element: "subjects/\(subject)/attempted", value: attempted + 1)
                        }
                    }
                }
                
                // Update stats if answered correctly.
                if correct {
                    readUserData(userId: userId, element: "difficulties/\(catDiff)/answeredCorrectly") { answered in
                        let answered = answered as? Int ?? 0
                        writeUserData(userId: userId, element: "difficulties/\(catDiff)/answeredCorrectly", value: answered + 1)
                    }
                    for subject in subjects {
                        readUserData(userId: userId, element: "subjects/\(subject)/answeredCorrectly") { answered in
                            let answered = answered as? Int ?? 0
                            writeUserData(userId: userId, element: "subjects/\(subject)/answeredCorrectly", value: answered + 1)
                        }
                    }
                    
                    // Remove from answeredIncorrectly.
                    readUserData(userId: userId, element: "answeredIncorrectly") { snapshot in
                        if let questions = snapshot as? [String: Int] {
                            let ref = Database.database().reference().child("users").child(userId).child("answeredIncorrectly")
                            for (key, value) in questions {
                                if value == questionId {
                                    ref.child(key).removeValue { _, _ in }
                                }
                            }
                        }
                    }
                    
                    // Remove from eligible questions.
                    readUserData(userId: userId, element: catEligible) { snapshot in
                        if let questions = snapshot as? [Int?] {
                            let ref = Database.database().reference().child("users").child(userId).child(catEligible)
                            for num in questions {
                                if let key = num, key == questionId {
                                    ref.child("\(key)").removeValue { _, _ in }
                                }
                            }
                        }
                    }
                }
                
                // Update stats if answered incorrectly.
                else {
                    pushUserData(userId: userId, element: "answeredIncorrectly", value: questionId)
                }
            }
        }
    }
    
    static func getAnsweredIncorrectly(completion: @escaping ([Int]) -> Void) {
        readUserData(userId: getUserId(), element: "answeredIncorrectly") { snapshot in
            var array: [Int] = []
            if snapshot is Error {
                completion(array)
                return
            }
            if let questions = snapshot as? [String: Int] {
                for (_, value) in questions {
                    array.append(value)
                }
                completion(array)
            }
        }
    }
    
    static func addAnsweredIncorrectly(question: Int) {
        pushUserData(userId: getUserId(), element: "answeredIncorrectly", value: question)
    }
    
    static func removeAnsweredIncorrectly(question: Int) {
        readUserData(userId: getUserId(), element: "answeredIncorrectly") { snapshot in
            if snapshot is Error { return }
            if let questions = snapshot as? [String: Int] {
                let ref = Database.database().reference().child("users").child(getUserId()).child("answeredIncorrectly")
                for (key, value) in questions {
                    if value == question {
                        ref.child(key).removeValue { _, _ in }
                    }
                }
            }
        }
    }
    
    static func getDailyStreak(completion: @escaping (Int) -> Void) {
        readUserData(userId: getUserId(), element: "dailyStreak") { snapshot in
            let streak = snapshot as? Int ?? 0
            completion(streak)
        }
    }
    
    static func addDailyStreak() {
        readUserData(userId: getUserId(), element: "dailyStreak") { snapshot in
            let streak = snapshot as? Int ?? 0
            writeUserData(userId: getUserId(), element: "dailyStreak", value: streak + 1)
        }
    }
    
    static func resetDailyStreak() {
        writeUserData(userId: getUserId(), element: "dailyStreak", value: 0)
    }
    
    static func getFriends(completion: @escaping ([String]?) -> Void) {
        readUserData(userId: getUserId(), element: "friends") { snapshot in
            if snapshot is Error {
                completion(nil)
                return
            }
            if let friends = snapshot as? [String: String] {
                var array: [String] = []
                for (_, value) in friends {
                    array.append(value)
                }
                completion(array)
                return
            }
        }
    }
    
    static func checkIfUserExists(email: String, completion: @escaping (Bool) -> Void) {
        let dbRef = Database.database().reference()
        let usersRef = dbRef.child("all-users")

        usersRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                let users = snapshot.value as? [String: String] ?? [:]
                let emails = Array(users.values)
                completion(emails.contains(email))
            } else {
                completion(false)
            }
        }
    }
    
    static func getFriendId(email: String, completion: @escaping (String) -> Void) {
        var UUID = ""
        let ref = Database.database().reference().child("all-users")
        ref.observeSingleEvent(of: .value) { snapshot in
            if let friends = snapshot.value as? [String: String] {
                for (key, value) in friends {
                    if value == email {
                        UUID = key
                        completion(UUID)
                    }
                }
            }
        }
    }
    
    static func getFriendEmail(UUID: String, completion: @escaping (String) -> Void) {
        var email = ""
        let ref = Database.database().reference().child("all-users")
        ref.observeSingleEvent(of: .value) { snapshot in
            if let friends = snapshot.value as? [String: String] {
                for (key, value) in friends {
                    if key == UUID {
                        email = value
                        completion(email)
                    }
                }
            }
        }
    }
    
    static func isFriend(userId: String, completion: @escaping (Bool) -> Void) {
        readUserData(userId: getUserId(), element: "friends") { snapshot in
            if snapshot is Error {
                completion(false)
                return
            }
            if let friends = snapshot as? [String: String] {
                for (_, value) in friends {
                    if value == userId {
                        completion(true)
                        return
                    }
                }
            }
            completion(false)
        }
    }
    
    static func addFriend(email: String) {
        getFriendId(email: email) { UUID in
            isFriend(userId: UUID) { isFriend in
                if !isFriend {
                    pushUserData(userId: getUserId(), element: "friends", value: UUID)
                    pushUserData(userId: UUID, element: "friends", value: getUserId())
                }
            }
        }
    }
    
    static func getTokens(completion: @escaping (Int) -> Void) {
        readUserData(userId: getUserId(), element: "tokens") { snapshot in
            if let tokens = snapshot as? Int {
                completion(tokens)
            }
        }
    }
    
    static func getLeaderboard(completion: @escaping ([(String, Int, Int)]?) -> Void) {
        var leaderboard: [(String, Int, Int)] = []
        var usersAndTokens: [String: Int] = [:]
        var email: String = ""
        
        if let currentUser = Auth.auth().currentUser {
            email = currentUser.email ?? ""
        }
        
        readUserData(userId: getUserId(), element: "tokens") { snapshot in
            if let tokens = snapshot as? Int {
                usersAndTokens[email] = tokens
                print(email)
                print(tokens)
                
                readUserData(userId: getUserId(), element: "friends") { snapshot in
                    if snapshot is Error {
                        return
                    }
                    
                    if let friends = snapshot as? [String: String] {
                        var friendIds: [String] = []
                        
                        for (_, friendId) in friends {
                            friendIds.append(friendId)
                        }
                        
                        let ref = Database.database().reference().child("all-users")
                        
                        ref.observeSingleEvent(of: .value) { snapshot, _ in
                            if let allUsers = snapshot.value as? [String: String] {
                                for (key, value) in allUsers {
                                    if friendIds.contains(key) {
                                        let ref = Database.database().reference().child("users").child(key).child("tokens")
                                        
                                        ref.observeSingleEvent(of: .value) { snapshot, _ in
                                            if let tokens = snapshot.value as? Int {
                                                usersAndTokens[value] = tokens
                                                print(value)
                                                print(tokens)
                                            }
                                        }
                                    }
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    let sortedArray = usersAndTokens.sorted { $0.value > $1.value }
                                    
                                    leaderboard = sortedArray.enumerated().map { (index, item) in
                                        let place = index + 1
                                        return (item.key, item.value, place)
                                    }
                                    
                                    completion(leaderboard)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    static func addTokens(numTokens: Int) {
        readUserData(userId: getUserId(), element: "tokens") { snapshot in
            let tokens = snapshot as? Int ?? 0
            writeUserData(userId: getUserId(), element: "tokens", value: tokens + numTokens)
        }
    }
    
    static func getPremiumStatus(completion: @escaping (Bool) -> Void) {
        readUserData(userId: getUserId(), element: "isPremiumMember") { snapshot in
            let status = snapshot as? Bool ?? false
            completion(status)
        }
    }
    
    static func setPremiumStatus(status: Bool) {
        writeUserData(userId: getUserId(), element: "isPremiumMember", value: status)
    }
    
    static func getSoundEnabled(completion: @escaping (Bool) -> Void) {
        readUserData(userId: getUserId(), element: "soundEnabled") { snapshot in
            let enabled = snapshot as? Bool ?? true
            completion(enabled)
        }
    }
    
    static func setSoundEnabled(status: Bool) {
        writeUserData(userId: getUserId(), element: "soundEnabled", value: status)
    }
}
