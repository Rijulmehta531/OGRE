//
//  PracticeQuestionView.swift
//  ogre
//
//  Created by Samujjwal Kumar on 11/1/23.
//  Worked out by Sam & Rijul



import SwiftUI
struct PracticeQuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    
    func stringToAnswer(_ string: String) -> Answer {
        return Answer(text: AttributedString(string), isCorrect: false)
    }
    
    
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 40) {
                    HStack{
                        Text("OGRE")
                            .lilacTitle()
                        Spacer()
                        Text("Practice")
                            .foregroundColor(Color.accentColor)
                            .fontWeight(.heavy)
                            .frame(alignment: .center)
                            .offset(x:-25)
                        
                        Spacer()
                        
                        NavigationLink(destination: MainMenuView()) {
                            Text("Exit")
                                .foregroundColor(Color.accentColor)
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        .navigationBarHidden(true)
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
                                else if(!question.answers.isEmpty && question.type == "checkbox"){
                                    ForEach(question.answers, id: \.id){
                                        answer in Checkbox(answer: answer)
                                            .environmentObject(quizManager)
                                    }
                                }
                            else if(question.type == "multiple_radio"){
                                         AnswerRow(answer: stringToAnswer("Under Construction"))
                                        .environmentObject(quizManager)
                                }
                                
                                else{
                                    if question.type == "small_text"{
                                        TextField("Enter your answer", text: $quizManager.shortAns)
                                            .border(Color.accentColor)
                                            .onChange(of: quizManager.shortAns) { _ in
                                                quizManager.answerSelected = !quizManager.shortAns.isEmpty
                                            }
                                    }
                                    else{
                                        TextEditor(text: $quizManager.longAns)
                                            .border(Color.accentColor)
                                            .onChange(of: quizManager.longAns) { _ in
                                                quizManager.answerSelected = !quizManager.longAns.isEmpty
                                            }
                                    }
                                    
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
                            quizManager.isShowingPopup = false
                            if quizManager.index == 1{
                                quizManager.isSubmitButtonPressed = true
                            }
                            else{
                                quizManager.isSubmitButtonPressed.toggle()
                            }
                            quizManager.shortAns = ""
                            quizManager.longAns = ""
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
                            WebView(htmlString: quizManager.feedbackMessage)
                                .frame(height: 300)
                                .background(Color.black.opacity(0.8))
                            
                            // A button to dismiss the pop up window
                            Button(action: {
                                // Set the isShowingPopUp variable to false
                                quizManager.isShowingPopup = false
                            }) {
                                Text("Close")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(quizManager.feedbackColor)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                            }
                        }
                        .frame(width:370 ,height:690)
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
            
        }
    }
}
    
    

#Preview {
    PracticeQuestionView()
        .environmentObject(QuizManager())
        .navigationBarHidden(true)
}
