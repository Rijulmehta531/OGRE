import SwiftUI

struct OnboardingView: View {
  

    var body: some View {
        WalkthroughScreen()
    }
}

struct WalkthroughScreen: View {
    @State private var currentPage = 1
    @State private var buttonOpacity = 1.0
    @State private var path = NavigationPath()
    var body:some View{
        NavigationStack() {
            ZStack{
                if currentPage==1{
                    ScreenView(image: "obj1", detail: "Hey there, fellow test-takers! I'm your friendly neighborhood squirrel, and I'm here to tell you about the ultimate GRE app that's going to make your prep a total breeze. I call it \"OGRE\" 🐿️📚",bgColor: Color.black,tColor: Color.bgColor1)
                        .transition(.scale)
                }
                if currentPage==2{
                    ScreenView(image: "obj2", detail: "Picture this: you, acing the GRE like a pro, from the comfort of your treehouse or favorite coffee shop. With \"OGRE,\" you've got personalized tests that adapt to your strengths and weaknesses. It's like having a nut stash tailored just for you!",bgColor: Color.black,tColor: Color.bgColor1)
                    .transition(.scale)}
                if currentPage==3{
                    ScreenView(image: "obj3", detail: "But that's not all, folks. We've got study materials that are as fresh as the juiciest acorns, and a bunch of cool features that'll make you jump for joy (figuratively, of course). Whether you're a GRE newbie or a seasoned squirrel, this app has got you covered.",bgColor: Color.black,tColor: Color.bgColor1)
                    .transition(.scale)}
                if currentPage==4{
                    InitiQuesView()
                }
                if currentPage==5{
                    MainMenuView()
                }
                }
            }
            .overlay{
                //button
                Button(action: {
                    //changing views
                    withAnimation(.easeInOut){
                        if currentPage<=totalPages+1{
                            currentPage+=1
                        }
                        if currentPage==totalPages+1 {
                            buttonOpacity = 0
                            AuthenticationViewModel().hasCompletedOnboarding = true
                        }
                    }
                }, label: {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 60,height: 60)
                        .background(Color.bgColor1)
                        .clipShape(Circle())
                        
                    
                    //Circular Slider
                        .overlay{
                            ZStack{
                                Circle()
                                    .stroke(Color.white.opacity(0.04),lineWidth: 4)
                                
                                Circle()
                                    .trim(from: 0,to:CGFloat(currentPage)/CGFloat(totalPages))
                                    .stroke(Color.bgColor1,lineWidth: 4)
                                    .rotationEffect(.init(degrees: -90))
                            }
                            .padding(-15)
                        }
                        .opacity(buttonOpacity)
                })
                .padding(.bottom,20)
                .offset(y:330)}
                
            }
        }


struct ScreenView: View {
    var image:String
    var detail:String
    var bgColor: Color
    var tColor: Color
    
    @State var currentPage=1
    var body: some View {
        VStack(spacing:20){
            HStack{
                if currentPage==1{
                    Text("Hello Stranger!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                        .foregroundStyle(tColor)
                }
                else{
                    //Back Button
                    Button(action: {
                        withAnimation(.easeInOut(duration:0.3)){currentPage-=1}
                    }, label: {
                        Image(systemName: "chevron.left")
                            .background(Color.white.opacity(0.1))
                            .foregroundColor(Color.bgColor1)
                            .padding(.horizontal)
                            .padding(.vertical,10)
                            .cornerRadius(10)
                    })
                }
                Spacer()

            }
            .foregroundColor(tColor)
            .padding()
            
            Spacer(minLength: 0)
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200,height: 200)
                .offset(y:-50)
            
            Text(detail)
                .fontWeight(.semibold)
                .font(.title2)
                .kerning(1.3)
                .multilineTextAlignment(.center)
                .foregroundColor(tColor)
                .offset(y:-30)
                .padding()
            Spacer(minLength: 90)
        }
        .background(bgColor.ignoresSafeArea())
    }
}

var totalPages=3

#Preview {
    OnboardingView()
}
