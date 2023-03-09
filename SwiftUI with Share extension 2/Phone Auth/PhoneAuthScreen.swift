//
//  PhoneAuthScreen.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/5/23.
//

import SwiftUI
struct PhoneAuthScreen: View {
  //  @State var phoneNumber:String
    @FocusState var isFocused:Bool
    @StateObject var viewModel = PhoneAuthViewModel()

    
    @State var isPresented = true

    
    var body: some View {
        
    
        
        switch viewModel.state {
            
        case .success(let data):
            
            NavigationLink(destination: SMSVerificationScreen(viewModel: viewModel), isActive:$isPresented) {Text("")}
           
            
        case .loading:
            
           test()
            
                .overlay(
                    ZStack{
                        BlurView
                        LoadingView(model: EnvObject(), text: "loading")
                    }
                    

                )
                
          
    
            
        default:
          test()
            //break
            //BlurView
//                    .alert(isPresented: $isErrorPresented){
//                        Alert(title: Text("Error"), message: Text(""), dismissButton: .default(Text("OK")))
//
//                    }

              
            
         


        }
        

    }
    
    
    // MARK: OTP Text Box
    @ViewBuilder
    func test()->some View{
        
        ZStack(alignment: .top){
            Color.clear
            VStack(spacing: 0){
                
                VStack(spacing: 5){
                    Text("Your Phone")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                        .font(Font.custom("FiraSans-Medium", size: 35))
                    Text("Please enter your number create an account")
                        .font(Font.custom("FiraSans-Medium", size: 16))
                        .padding(.leading,4)
                    
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(.top,10)
                
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack(spacing: 0){
                    Image("PhoneAuthPerson3")
                        .resizable()
                        .scaledToFit()
                        .padding(.top,isFocused ? 30 : 60)
                        .animation(.default)
                    
                }
                
                .ignoresSafeArea()
                //.frame(height: UIScreen.screenHeight*0.3)
                .animation(.default)
                
                
                //                CustomTextField(hint: "07xxxxxxxx", text: $phoneNumber, contentType: .telephoneNumber)
                CustomTextField(hint: "07xxxxxxxx", text: $viewModel.number, isEnabled: _isFocused, contentType: .telephoneNumber)
                //.padding(.top,100)
                    .padding(.top,isFocused ? 20 : 100)
                    .animation(.default)
                
                
                Button("send") {
                    
                    Task{
                        await viewModel.sendOTP()
                        
                    }
                }
                
                .padding(.vertical,20)
                .padding(.horizontal,80)
                .background(CustomColor.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .foregroundColor(.white)
                .font(Font.custom("FiraSans-Medium", size: 20))
                
                
                
                
                .padding(.top,isFocused ? 15 : 100)
                .animation(.default)
                
            }
            
        }
        .padding(.horizontal,25)
        
        .background(
            Image("SplashScreenBG")
                .rotationEffect(Angle(degrees: 180))
                .animation(.default)
            
            //    .fixedSize()
        )
        //.ignoresSafeArea()
        .onTapGesture {
            isFocused = false
        }
        
        .alert(viewModel.errorMessage,isPresented: $viewModel.showAlert){
        }
        
        
        
        
        
    }
}

struct PhoneAuthScreen_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthScreen()
    }
}
