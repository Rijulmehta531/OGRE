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
                        let eligibleVR: [Int] = [23, 32, 37, 80, 99, 101, 102, 107, 112, 126, 142, 151, 168, 170, 176, 197, 199, 201, 218, 220, 241, 259, 273, 274, 275, 276, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 296, 297, 298, 299, 300, 301, 302, 303, 304, 305, 306, 307, 308, 309, 310, 311, 312, 313, 314, 315, 316, 317, 318, 319, 320, 321, 322, 323, 324, 325, 326, 327, 328, 329, 330, 331, 332, 333, 334, 335, 336, 337, 338, 339, 340, 341, 342, 343, 344, 345, 346, 347, 348, 349, 350, 351, 352, 353, 354, 355, 356, 357, 358, 359, 360, 361, 362, 363, 364, 365, 366, 367, 368, 369, 370, 371, 372, 373, 374, 375, 376, 377, 378, 379, 380, 381, 382, 383, 384, 385, 386, 387, 388, 389, 390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 690, 691, 692, 693, 694, 695, 696, 697, 698, 699, 700, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 715]
                        writeUserData(userId: userId, element: "eligibleVR", value: eligibleVR)
                    }
                }
            }
        }
    }
    
    static func getEligibleQuestion(category: String, completion: @escaping (Int) -> Void) {
        var element: String
        if category == "QR" {
            element = "eligibleQR"
        } else if category == "VR" {
            element = "eligibleVR"
        } else {
            print("Invalid category")
            return
        }
        readUserData(userId: getUserId(), element: element) { snapshot in
            let questions = snapshot as? [Int] ?? []
            let questionId: Int = questions.randomElement() ?? 0
            completion(questionId)
        }
    }
    
    static func answeredQuestion(questionId: Int, correct: Bool) {
        
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
    
    static func getLeaderboard(completion: @escaping ([String]?) -> Void) {
        var leaderboard: [String] = []
        var usersAndTokens: [String: Int] = [:]
        var email: String = ""
        if let currentUser = Auth.auth().currentUser {
            email = currentUser.email ?? ""
        }
        readUserData(userId: getUserId(), element: "tokens") { snapshot in
            if let tokens = snapshot as? Int {
                usersAndTokens[email] = tokens
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
                                            }
                                        }
                                    }
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    let sortedArray = usersAndTokens.sorted { $0.value > $1.value }
                                    leaderboard = sortedArray.map { "\($0.key): \($0.value)" }
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
