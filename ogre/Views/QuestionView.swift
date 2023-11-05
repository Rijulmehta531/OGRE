
//  QuestionView.swift
//  OGRE Prototype
//
//  Created by Sam Kumar 10/15/2023
//

import SwiftUI
struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    @State var isTimerEndSoundPlaying = false
    @State var isTimerPlaying = false
    
    @State var isSubmitButtonClicked = false
    @State var timeRemaining = 20
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack(spacing: 40) {
            HStack{
                Text("OGRE")
                    .lilacTitle()
                Spacer()
                TimerView(timeRemaining: $timeRemaining)
                    .onReceive(timer, perform: { _ in
                        if timeRemaining > 0 && !isSubmitButtonClicked{
                            timeRemaining -= 1
                        }
                        else{
                            let defaultAnswer = Answer(text: AttributedString("No Selection"), isCorrect: false)
                            quizManager.goToNextQuestion(answer: quizManager.currentAnswer ?? defaultAnswer)
                            timeRemaining = 20
                            isTimerPlaying = false
                            isTimerEndSoundPlaying = false
                        }
                        if timeRemaining > 4 && !isTimerPlaying {
                                SoundManager.instance.playSound(sound: .timer)
                                isTimerPlaying = true
                            }
                        if timeRemaining <= 4 && !isTimerEndSoundPlaying {
                                SoundManager.instance.playSound(sound: .timeEnding)
                                isTimerEndSoundPlaying = true
                            }
                    })
                
                Spacer()
                
               
                
                Text("\(quizManager.index + 1) out of \(quizManager.length)")
                    .foregroundColor(Color.accentColor)
                    .fontWeight(.heavy)
                
            }
            ProgressBar(progress: quizManager.progress)
            
            VStack(alignment:.leading, spacing: 20){
                Text(quizManager.question)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundColor(.black)
                
                ForEach(quizManager.answerChoices, id: \.id){
                    answer in AnswerRow(answer: answer)
                        .environmentObject(quizManager)
                }
            }
            
            Button{
                quizManager.isSubmitButtonPressed.toggle()
                timeRemaining = 20
            } label: {
                PrimaryButton(text: "Submit", background: quizManager.answerSelected ? Color("AccentColor") : Color(hue:1.0, saturation: 0.0, brightness: 0.564, opacity: 0.327))
            }
            .disabled(!quizManager.answerSelected) // Disabled until 1 answer is selected
            
            Spacer()
            
            
        }
        .padding()
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight: .infinity)
        .navigationBarHidden(true)
        
    }
        
}

#Preview {
    QuestionView()
        .environmentObject(QuizManager())
}
