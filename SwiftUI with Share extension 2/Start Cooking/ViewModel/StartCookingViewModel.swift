//
//  StartCookingViewModel.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/3/23.
//

import Foundation
import Speech
import SwiftUI
final class StartCookingViewModel:ObservableObject{
    enum Result {
        case na
        case loading
        case success(data:Recipe)
        case faild(error:Error)
    }
    
    //MARK: - Local Properties
    var audioEngine = AVAudioEngine()
    let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer()
    let request = SFSpeechAudioBufferRecognitionRequest()//object to perform speech recognition on live audio on specified buffer
    @State var task : SFSpeechRecognitionTask!//To control recognizer state (cancel it or)
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var commands = "Instruction:"
    @State private var btnTitle = ""
    @State private var imageName = ""
    
    @Published var currentPage = 0
    
    @Published var hasError = false //tells our view if an error has occured
    @Published var error:String? // holds the error
    
    
    
    @State var steps = [Step(name: "Heat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food StudiosHeat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food Studios", order: 1),Step(name: "Your pancake will tell you when it's ready to flip. Wait until bubbles start to form on the top and the edges look dry and set. This will usually take about two to three minutes on each side", order: 2),Step(name: "Make a well", order: 3),Step(name: "Store leftover pancakes in an airtight container in the fridge for about a week. Refrain from adding toppings (such as syrup) until right before you serve them so the pancakes don't get soggy.", order: 4)]//delete later
    
    
   
    
    

    
    func backStep(){
        if currentPage > 0 {
            currentPage -= 1
        }
    }
    
    func nextStep(){
        if currentPage < steps.count - 1 {
            currentPage += 1
        }
    }
    
    
    
    
    
    
    func setError(message: String) {
        hasError = true
        error = message
    }
  
}



//MARK: Voice Commands
extension StartCookingViewModel {
    
    //A function to request user's permission to speech recongizer via phone microphone
    func requestPermission() {
        SFSpeechRecognizer.requestAuthorization { [weak self] authState in
            OperationQueue.main.addOperation{
                if authState == .authorized {
                    print("Accepted")
                    //enable microphone button
                    
                } else if authState == .denied {
                    self?.setError(message: "user denied mic persmission")
                } else if authState == .notDetermined {
                    self?.setError(message: "your phone has no speech recognizer")
                } else if authState == .restricted {
                    self?.setError(message: "your phone has been restricted from speech recognizer")
                }
                
                
            }
            
        }
        
    }
    
    
    
    func startSpeechRecognization(){
        //Takes audio input by audio engine creating a singleton when accessing the variable
        let node = audioEngine.inputNode
        //Retrieves the output format for the bus(signal path) specified
        let recordingFormat = node.outputFormat(forBus: 0)
        
        
        //To start recording, monitoring, and observing the output of audio input node
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, audioTime in
            //specify the buffer for the live audio
            
            self.request.append(buffer)
        }
        
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            
        } catch let error {
            
            setError(message: "error preparing the audio")
            
        }
        
        //check Speech recognition availability in user's location/local
        guard let myRecgonition = SFSpeechRecognizer() else {
            
            setError(message: "Recgonization is not allowed in your location")
            
            return
        }
        
        //check Speech recognition availability if it is currently in use or free
        if !myRecgonition.isAvailable {
            
            setError(message: "Speech Recognizer is not available please try again later")
        }
        
        //
        
        task = speechReconizer?.recognitionTask(with: request) { [weak self](response,error) in
            guard let response = response else {
                if error != nil {
                    
                    self?.setError(message: error.debugDescription)
                    
                }
                else {
                    self?.setError(message: "something went wrong with giving a respone")
                    
                }
                
                return
            }
            
            
            //get transcription with the highest confidence level
            var message = response.bestTranscription.formattedString
            // self.lb_speech.text = message
            
            self?.commands = message
            
            
            var lastString: String = ""
            for segment in response.bestTranscription.segments {
                let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
                lastString = String(message[indexTo...])
            }
            
            if lastString == "next" {
                self?.nextStep()
            } else if lastString.elementsEqual("back") {
                self?.backStep()
                
            } else if lastString.elementsEqual("repeat") {
                print("repeat")
                
            }
            
        }
        
        
        
        
    }
    
    
    func cancelSpeechRecognization() {
        task.finish()
        task.cancel()
        task = nil
        
        request.endAudio()
        audioEngine.stop()
        //audioEngine.inputNode.removeTap(onBus: 0)
        
        //check if there exist an input node that's taking audio to remove it
        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
}
