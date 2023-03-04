//
//  StartCookingViewModel.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/3/23.
//

import AVFoundation
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
    var request = SFSpeechAudioBufferRecognitionRequest()//object to perform speech recognition on live audio on specified buffer
    @State var task : SFSpeechRecognitionTask?//To control recognizer state (cancel it or)
//    @Published var task  = SFSpeechRecognitionTask()//To control recognizer state (cancel it or)

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var commands = "Instruction:"
    @State private var btnTitle = ""
    @State private var imageName = ""
    
    @Published var currentPage = 0
    @Published var isSpeaking = false
    
    
    @Published var hasError = false //tells our view if an error has occured
    @Published var error:String? // holds the error
    
    
    
    
    @State var synthesizer = AVSpeechSynthesizer()
    @Published var isReading = false
    //specify what we want to say
    @Published var utterance = AVSpeechUtterance(string: "step ")
    
    
    
    
    @State var steps = [Step(name: "Heat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food StudiosHeat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food Studios", order: 1),Step(name: "Your pancake will tell you when it's ready to flip. Wait until bubbles start to form on the top and the edges look dry and set. This will usually take about two to three minutes on each side", order: 2),Step(name: "Make a well", order: 3),Step(name: "Store leftover pancakes in an airtight container in the fridge for about a week. Refrain from adding toppings (such as syrup) until right before you serve them so the pancakes don't get soggy.", order: 4)]//delete later
    
    
    
    
    
    
    
    func backStep(){
        if currentPage > 0 {
            currentPage -= 1
        checkReading()

        }
    }
    
    func nextStep(){
        if currentPage < steps.count - 1 {
            currentPage += 1
            checkReading()

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
    private func requestPermission() {
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
    
    
    
    private func startSpeechRecognization(){
        //Takes audio input by audio engine creating a singleton when accessing the variable
        let node = audioEngine.inputNode
        
        //check if there exist an input node that's taking audio to remove it
        node.removeTap(onBus: 0)

        
        //Retrieves the output format for the bus(signal path) specified
        let recordingFormat = node.outputFormat(forBus: 0)
        //if recordingFormat.sampleRate == 0.0 { return }
        
        //To start recording, monitoring, and observing the output of audio input node
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, audioTime in
            //specify the buffer for the live audio
            
            self.request.append(buffer)
        }
        
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
            
        } catch {
            
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
        

        
        // This resets the recognitionRequest so "...cannot be re-use..." error is avoided.
        request = SFSpeechAudioBufferRecognitionRequest()   // recreates recognitionRequest object.
//        guard let request = request else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        
        task = (speechReconizer?.recognitionTask(with: request) { [weak self](response,error) in
            guard let response = response else {
                if error != nil {
                    
                    self?.setError(message: error.debugDescription)
                    print("im here")
                }
                else {
                    self?.setError(message: "something went wrong with giving a respone")
                    
                }
                
                return
            }
            
            
            //get transcription with the highest confidence level
            let message = response.bestTranscription.formattedString
            // self.lb_speech.text = message
            
            self?.commands = message
            var lastWord: String = ""
            
            for segment in response.bestTranscription.segments {
                if self?.isSpeaking == false {
                    return
                }
                
                let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
                lastWord = String(message[indexTo...])
                print("lastString is: \(lastWord)")
             
                
                if lastWord.lowercased() == "next" {
                    self?.nextStep()
                } else if lastWord.lowercased() == "back" {
                    self?.backStep()
                    
                } else if lastWord.lowercased() == "repeat" {
                    self?.checkReading()
                    print("repeat")
                    
                }
                print(lastWord)
                
            }
            
          
            
        })!
        
        
        
        
    }
    
    
    private func cancelSpeechRecognization() {
       
        request.endAudio()
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        task?.finish()
        task?.cancel()
        task = nil
        
        //check if there exist an input node that's taking audio to remove it
        if audioEngine.inputNode.numberOfInputs > 0 {
            audioEngine.inputNode.removeTap(onBus: 0)
        }
    }
    
    func checkSpeaking(){
        if isSpeaking {
            requestPermission()
            print("start speech recgonizing")
            startSpeechRecognization()
        }
        else {
            cancelSpeechRecognization()
        }
    }
    
    
}



extension StartCookingViewModel {
    
    
    private func startReading(step:Step) {
        isReading = true
        utterance = AVSpeechUtterance(string: "Step \(step.orderID) \(step.name)")
//        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.speech.voice.Alex")
    //    utterance.rate = 0.45 //slows down the reading speed
      //  utterance.pitchMultiplier = 1.5
        //an object that does the reading for us based on the utterance configurations
        synthesizer.speak(utterance)
    }
    
    
    private func stopReading() {
        isReading = false
        synthesizer.stopSpeaking(at: .immediate)
    }
    
    //Decides wheather to read or to stop reading
    func checkReading() {
        if isReading == true{
            stopReading()
            startReading(step: steps[currentPage])
        }
        else {
            stopReading()
        }
    }
    
    
}



