//
//  ViewModel.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/6/23.
//


//Model

//View

//ViewModel => Logic


//ViewModel
/**
 @Published var phoneNumber:String = ""
 
 
 **/


//in view

//@StateObject let vm = ViewModel()
//Button("send"){

//vm.sendOTP()
//}



import Foundation

import SwiftUI
import Firebase
@MainActor //To perform on main thread in order to update our UI

class PhoneAuthViewModel: ObservableObject {
    //MARK: Phone
    @Published var number: String = ""
    @Published var code: String = "+962"
    //MARK: Error
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    @Published var otpField = "" {
        didSet {
            isSendDisabled = otpField.count < 6
            guard otpField.count <= 6,
                  otpField.last?.isNumber ?? true else {
                otpField = oldValue
                return
            }
        }
    }
    
    //MARK: OTP Credentials
    @Published var verificationCode: String = ""
    
    
    
    @Published var isTextFieldDisabled = false
    @Published var isSendDisabled = true
    var successCompletionHandler: (()->())?
    
    @Published var showResendText = false
    
    
    @Published private(set) var state: State = .na
    @Published private(set) var state2: State = .na
    enum State {
        case na
        case loading
        case success(data:String)
        case faild(error:Error)
    }
    
    
    
    //MARK: Sending OTP
    func sendOTP() async {
        print("i got called \(code)\(number)")
        self.state = .loading
        do {
            let result = try await PhoneAuthProvider.provider().verifyPhoneNumber("\(code)\(number)", uiDelegate: nil)
            //            DispatchQueue.main.async {
            //                self.verificationCode = result
            //                self.state = .success(data: "success")
            //
            //            }
            
            await MainActor.run(body: {
                verificationCode = result
                self.state = .success(data: "success")
                
            })
            
            
        } catch  {
            handleError(error: error.localizedDescription)
            self.state = .faild(error: error)
        }
        state = .na
    }
    
    
    //MARK: Verify SMS Code
    func verifyOTPCode() async {
        
            self.state2 = .loading
            do {
                print(verificationCode)
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.verificationCode,verificationCode: self.otpField)
                try await Auth.auth().signIn(with: credential)
                AppStorage("log_status").wrappedValue = true
                self.state2 = .success(data: "success")
                print()
            }catch{
                await handleError (error: error.localizedDescription)
                self.state2 = .faild(error: error)

                
            }
            
        
    }
    
    
    func handleError(error: String) {
        DispatchQueue.main.async {
            self.errorMessage = error
            self.showAlert.toggle()
        }
    }
    
    
    
}
