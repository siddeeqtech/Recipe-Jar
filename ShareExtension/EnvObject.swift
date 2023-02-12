//
//  EnvObject.swift
//  ShareExtension101
//
//  Created by othman shahrouri on 10/28/22.

//

import Foundation
import OpenAISwift
//Class used to share data between UIkit ShareViewController (extension) and SwiftUI (Form sheet)
@MainActor class EnvObject: ObservableObject {
    
    
    @Published var data = "empty url for now"
    @Published var recipeDetails = "empty for now"
    private var client: OpenAISwift?
    
    
    //A connection with uikit safari extension to call uikit function in swiftui view telling safari extension work is completed
    internal var uIViewController: CustomShareViewController? = nil
    
    
    func cancelAction(){
            if uIViewController != nil{
                uIViewController!.cancelAction()
            }else{
                print("view controller is not connected")
            }
        }
    func doneAction(){
            if uIViewController != nil{
                uIViewController?.doneAction()
            }else{
                print("view controller is not connected")
            }
        }

    init(myvar: String) {

        self.data = myvar

    
        
    }
    
    
   
    
}
