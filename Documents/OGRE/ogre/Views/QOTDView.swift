//
//  QOTDView.swift
//  ogre
//
//  Created by Brian Johnson on 11/19/23.
//

import SwiftUI

struct QOTDView: View {
    @EnvironmentObject var quizManager: QuizManager
    @State private var lastClickTimestamp: Date?
    @State private var showStreakAlert = false
    var closePopover: () -> Void
    @State public var streakCount: Int = 0
    @State private var lastClickedDate: Date? = UserDefaults.standard.object(forKey: "lastClickedDate") as? Date
    
    init(closePopover: @escaping () -> Void) {
            // Initialize streakCount from UserDefaults
            _streakCount = State(initialValue: UserDefaults.standard.integer(forKey: "streakCount"))
        self.closePopover = closePopover
        }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 40) {
                    HStack{
                        Text("OGRE")
                            .lilacTitle()
                        Spacer()
                        Text("Question of the Day")
                            .foregroundColor(Color.accentColor)
                            .fontWeight(.heavy)
                            .frame(alignment: .center)
                            .offset(x:-25)
                        
                        Spacer()
                    }
                    
                    VStack(alignment:.leading, spacing: 20){
                        if let question = quizManager.question{
                            ScrollView {
                                //Text("Description:")
                                WebView(htmlString: question.descriptionHtml)
                                    .frame(minHeight: 150)
//                                    .border(.black)
                                    
                            }
                            .frame(height: 150)
                            
                            if(!question.answers.isEmpty){
                                ForEach(question.answers, id: \.id){
                                    answer in AnswerRow(answer: answer)
                                        .environmentObject(quizManager)
                                }
                            }
                            else{
                                Text("Answers is empty")
                            }
                        }
                    }
                    
                    HStack(spacing: 60) {
                        Button{
                            quizManager.checkAnswer()
                            quizManager.isShowingPopup = true
                        } label: {
                            PrimaryButton(text: "Check", background: quizManager.answerSelected ? Color("AccentColor") : Color(hue:1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                        }
                        .disabled(!quizManager.answerSelected)
                        
                        Button{
                            handleButtonClick()
                            showStreakAlert = true
                        } label: {
                            PrimaryButton(text: "Next", background: quizManager.answerSelected ? Color("AccentColor") : Color(hue:1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
                        }
                        .disabled(!quizManager.answerSelected)
                        
                    }
                    
                    Spacer()
                    
                    
                }
                .padding()
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
                
                
                if quizManager.isShowingPopup{
                    VStack(spacing: 20) {
                        ScrollView{
                            // A text view to show the feedback message
                            Text(quizManager.feedbackMessage)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            
                            // A button to dismiss the pop up window
                            Button(action: {
                                // Set the isShowingPopUp variable to false
                                quizManager.isShowingPopup = false
                            }) {
                                Text("OK")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(quizManager.feedbackColor)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                        }
                        .frame(width:370 ,height:250)
                    }
                    // A background with rounded corners for the pop up window
                    .padding()
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(20)
                    // An offset modifier to show or hide the pop up window based on the isShowingPopUp variable
                    // The offset value is calculated based on the height of the screen and the pop up window
                    //.offset(y: isShowingPopUp ? 0 : UIScreen.main.bounds.height)
                    .position(x:UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height - 120)
                    // An animation modifier to add some transition effects to the pop up window
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                }
            }// z stack
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .alert(isPresented: $showStreakAlert) {
            Alert(
                title: Text("Streak"),
                message: Text("Congrats! You have a \(streakCount) day streak! See you tomorrow!"),
                primaryButton: .default(Text("Back to home")) {
                    closePopover()
                },
                secondaryButton: .cancel() {
                    closePopover()
                }
                )
        }
    }
    func handleButtonClick() {
        let currentDate = Date()
        if let lastDate = lastClickedDate, Calendar.current.isDate(lastDate,inSameDayAs: currentDate) {
            streakCount += 1
        } else {
            streakCount = 1
        }
        lastClickedDate = currentDate
        UserDefaults.standard.set(currentDate, forKey: "lastClickedDate")
        UserDefaults.standard.set(streakCount, forKey: "streakCount")
    
    }
}

    #Preview {
        QOTDView(closePopover: {})
            .environmentObject(QuizManager())
            .navigationBarHidden(true)
    }


