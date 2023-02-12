////
////  SpecchRecognition.swift
////  SwiftUI with Share extension 2
////
////  Created by othman shahrouri on 11/1/22.
////
//
//import Foundation
//import Speech
//
//
//
////var audioEngine = AVAudioEngine()
////let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer()
////let request = SFSpeechAudioBufferRecognitionRequest()//object to perform speech recognition on live audio on specified buffer
////@State var task : SFSpeechRecognitionTask!//To control recognizer state (cancel it or)
////@State var isStart : Bool = false
//
//
////A function to request user's permission to speech recongizer via phone microphone
//func requestPermission(){
//    SFSpeechRecognizer.requestAuthorization { authState in
//        OperationQueue.main.addOperation{
//            if authState == .authorized {
//                print("Accepted")
//                //enable microphone button
//                 
//            } else if authState == .denied {
//                SharedFunctions.sharedInstance.showAlert(title: "Permission denied", message: "user denied mic persmission ")
//            } else if authState == .notDetermined {
//                SharedFunctions.sharedInstance.showAlert(title: "Not Determined", message: "your phone has no speech recognizer ")
//            } else if authState == .restricted {
//                SharedFunctions.sharedInstance.showAlert(title: "Restriced", message: "your phone has been restricted from speech recognizer ")
//            }
//            
//            
//        }
//        
//    }
//}
//
//
//func startSpeechRecognization(audioEngine: AVAudioEngine,request:SFSpeechAudioBufferRecognitionRequest,speechReconizer:SFSpeechRecognizer?,task:SFSpeechRecognitionTask?){
//    //Takes audio input by audio engine creating a singleton when accessing the variable
//    let node = audioEngine.inputNode
//    //Retrieves the output format for the bus(signal path) specified
//    let recordingFormat = node.outputFormat(forBus: 0)
//    
//    
//    //To start recording, monitoring, and observing the output of audio input node
//    node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, audioTime in
//        //specify the buffer for the live audio
//        
//        request.append(buffer)
//    }
//  
//    
//    audioEngine.prepare()
//    
//    do {
//        try audioEngine.start()
//   
//    } catch let error {
//        SharedFunctions.sharedInstance.showAlert(title: "error", message: "error preparing the audio")
//       
//    }
//  
//    //check Speech recognition availability in user's location/local
//    guard let myRecgonition = SFSpeechRecognizer() else {
//        SharedFunctions.sharedInstance.showAlert(title: "Error", message: "Recgonization is not allowed in your locatiobn")
//        return
//    }
//    
//    //check Speech recognition availability if it is currently in use or free
//    if !myRecgonition.isAvailable {
//        SharedFunctions.sharedInstance.showAlert(title: "not available", message: "Speech Recognizer is not available please try again later")
//    }
//    
//    //
//    
//    var task = speechReconizer?.recognitionTask(with: request) { (response,error) in
//        guard let response = response else {
//            if error != nil {
//                SharedFunctions.sharedInstance.showAlert(title: "error", message: error.debugDescription)
//            }
//            else {
//                SharedFunctions.sharedInstance.showAlert(title: "error", message: "something went wrong with giving a respone")
//            }
//            
//            return
//        }
//        
//        
//        //get transcription with the highest confidence level
//        var message = response.bestTranscription.formattedString
//       // self.lb_speech.text = message
//        
//        SharedFunctions.sharedInstance.commands = "\n" + message
//        
//        
//        var lastString: String = ""
//                    for segment in response.bestTranscription.segments {
//                        let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
//                        lastString = String(message[indexTo...])
//                    }
//                    
//                    if lastString == "next" {
//                        SharedFunctions.sharedInstance.imageName = "forward.fill"
//                    } else if lastString.elementsEqual("back") {
//                        SharedFunctions.sharedInstance.imageName = "backward.fill"
//                    } else if lastString.elementsEqual("repeat") {
//                        SharedFunctions.sharedInstance.imageName = "repeat"
//                    }
//        
//    }
//    
//    
//    
//    
//}
//
//
//
//
//func cancelSpeechRecognization(audioEngine: AVAudioEngine,request:SFSpeechAudioBufferRecognitionRequest,speechReconizer:SFSpeechRecognizer,task:SFSpeechRecognitionTask,commands:String) {
//    task.finish()
//    task.cancel()
//    task = nil
//
//    request.endAudio()
//    audioEngine.stop()
//    //audioEngine.inputNode.removeTap(onBus: 0)
//    
//    //check if there exist an input node that's taking audio to remove it
//    if audioEngine.inputNode.numberOfInputs > 0 {
//    audioEngine.inputNode.removeTap(onBus: 0)
//    }
//}
//
//
