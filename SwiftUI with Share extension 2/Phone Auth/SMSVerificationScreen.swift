//
//  SMSVerificationScreen.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/6/23.
//

import SwiftUI

struct SMSVerificationScreen: View {
    @StateObject var viewModel: PhoneAuthViewModel
    @FocusState var activeField:OTPField?

    
    @FocusState var isFocused:Bool
    @State var isPresented = true


    let textBoxWidth = UIScreen.main.bounds.width / 8
    let textBoxHeight = UIScreen.main.bounds.width / 8
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    
    var body: some View {
        
        
        switch viewModel.state2 {
            
        case .success(let data):
           
            NavigationLink(destination: HomeView(), isActive:$isPresented) {Text("")}
           
            
        case .loading:
            
           SmsView()
            
                .overlay(
                    ZStack{
                        BlurView
                        LoadingView(model: EnvObject(), text: "loading")
                    }
                    

                )
                
          
    
            
        default:
          SmsView()
            //break
            //BlurView
//                    .alert(isPresented: $isErrorPresented){
//                        Alert(title: Text("Error"), message: Text(""), dismissButton: .default(Text("OK")))
//
//                    }

              
            
         


        }
            
        
    }
    
    
    @ViewBuilder
    func SmsView() -> some View {
        ZStack(alignment: .topLeading){
            Color.clear
            VStack(spacing: 8){
                Text("SMS Code")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                    .font(Font.custom("FiraSans-Medium", size: 35))
                Text("Please enter your number create an account")
                    .font(Font.custom("FiraSans-Medium", size: 16))
                    .padding(.leading,4)
                
                    .frame(maxWidth: .infinity, alignment: .leading)
                //Spacer()
           
                
                ZStack {
                    
                    HStack (spacing: spaceBetweenBoxes){

                        ForEach(0..<6,id: \.self){ index in
                              OTPTextBox(index)
                        }
                        
                    }
                    
                    
                    TextField("", text: $viewModel.otpField)
                        .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                        .disabled(viewModel.isTextFieldDisabled)
                        .textContentType(.oneTimeCode)
                        .foregroundColor(.clear)
                        .accentColor(.clear)
                        .background(Color.clear)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    
                }
                
                
                
                    .padding(.top,UIScreen.screenHeight*0.2)
                
                
                Button("Verify") {
                    print("Button pressed!")
                    
                    Task {
                       await viewModel.verifyOTPCode()

                    }
                    
                }
                
                .padding(.vertical,20)
                .padding(.horizontal,80)
                .background(viewModel.isSendDisabled ? CustomColor.yellow.opacity(0.6) : CustomColor.yellow)
                .clipShape(RoundedRectangle(cornerRadius: 9, style: .continuous))
                .foregroundColor(.white)
                .font(Font.custom("FiraSans-Medium", size: 20))
                  
                    .padding(.top,isFocused ? 30 : 100)
                    .disabled(viewModel.isSendDisabled)
                    .animation(.default)
                
            }
            .padding(.top,20)
            .padding(.horizontal,20)
            //.frame(maxWidth: .infinity, alignment: .topLeading)
        }
        
        .background(
            Image("SplashScreenBG")
            //.rotationEffect(Angle(degrees: 270))
                .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
        )
        
        .onTapGesture {
         isFocused = false
        }
        .alert(viewModel.errorMessage,isPresented: $viewModel.showAlert){
        }
        
    }
    
    // MARK: OTP Text Box
    @ViewBuilder
    func OTPTextBox(_ index: Int)->some View{

        ZStack{
            
            if viewModel.otpField.count > index{
                // - Finding Char At Index
                let startIndex = viewModel.otpField.startIndex
                let charIndex = viewModel.otpField.index(startIndex, offsetBy: index)
                let charToString = String(viewModel.otpField[charIndex])
                Text(charToString)
            }
            else{
                Text ("")
            }
        }
        .frame (width: 45, height: 45)
        .background(

            VStack{
            //change color to status to change the animation
            // let status = (viewModel.otpField.count == index)
                let color = viewModel.otpField.count >= index+1
            Spacer()
            Rectangle()
                .fill(color ? .yellow : .gray.opacity(0.3))
                .frame(height: 4)
            
            
        })
        .padding(paddingOfBox)

       // .frame(maxWidth: .infinity)
    }
    


    
   
    
    
    
}
//MARK: FocusState Enum
enum OTPField {
    case field1
    case field2
    case field3
    case field4
    case field5
    case field6
}

struct SMSVerificationScreen_Previews: PreviewProvider {
    static var previews: some View {
        SMSVerificationScreen(viewModel: PhoneAuthViewModel())
    }
}
