//
//  ContentView.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 10/29/22.
//

import SwiftUI
import Speech
struct HomeView: View {
    //MARK: - Local Properties
        var audioEngine = AVAudioEngine()
        let speechReconizer : SFSpeechRecognizer? = SFSpeechRecognizer()
        let request = SFSpeechAudioBufferRecognitionRequest()//object to perform speech recognition on live audio on specified buffer
        @State var task : SFSpeechRecognitionTask!//To control recognizer state (cancel it or)
        @State var isStart : Bool = false
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var commands = "Instruction:"
    @State private var btnTitle = ""
    @State private var imageName = ""

    
    //Folders
    @State var presentAddFolder = false
    @State var folderName = ""
    @State var folders = CodeExtensions.sharedDefault.array(forKey: "folders") as? [String] ?? [String]()
    
    //Recipe Video
    
    let videoURL =  URL(string: "https://www.youtube.com/watch?v=QV4_kVIf4V4&ab_channel=iOSAcademy")!

    
    
    var body: some View {
        
        
        NavigationView {
            VStack {
              
                NavigationLink{
                    StepsScreen()
                }label: {
                    Text("Steps")
                }
                NavigationLink{
                    
                    YouTubeView(youTubePlayer: "https://www.youtube.com/watch?v=QV4_kVIf4V4&ab_channel=iOSAcademy")
                }label: {
                    Text("YouTube")
                }
                NavigationLink(destination: ScanRecipeView()) {
                    Text("Scan Recipe")
                }
                Spacer()
                
                VStack{
                   
                    Button("Create new folder"){
                        presentAddFolder = true
                        print("folder created")
                    }
                    .alert("Add Folder", isPresented: $presentAddFolder) {
                        TextField("Name",text: $folderName)
                        Button("Add"){
                            print(folderName)
                            folders.append(folderName)
                            CodeExtensions.sharedDefault.set(folders, forKey: "folders")
                            CodeExtensions.sharedDefault.synchronize()
                            folderName = ""
                        }
                    }
                    
                    List {
                        ForEach(folders,id:\.self) { folder in
                            Text(folder)
                        }
                    }
                    
                }
                Image(systemName: imageName)
                Button(btnTitle){
                    isStart.toggle()
                 
                    if isStart {
                        print("start speech recgonizing")
                       startSpeechRecognization()
                        btnTitle = "Cancel"
                    } else {
                        btnTitle = "Start"
                        cancelSpeechRecognization()
                    }
                   
                    
                    
                }
                .onAppear{
                    btnTitle = "Start"
                  requestPermission()
                    
                }
                
                Text(commands)
                
                
                
            }
            
               }
          
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK",role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    
    //A function to request user's permission to speech recongizer via phone microphone
    func requestPermission(){
        SFSpeechRecognizer.requestAuthorization { authState in
            OperationQueue.main.addOperation{
                if authState == .authorized {
                    print("Accepted")
                    //enable microphone button
                     
                } else if authState == .denied {
                    showAlert(title: "Permission denied", message: "user denied mic persmission ")
                } else if authState == .notDetermined {
                    showAlert(title: "Not Determined", message: "your phone has no speech recognizer ")
                } else if authState == .restricted {
                    showAlert(title: "Restriced", message: "your phone has been restricted from speech recognizer ")
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
            showAlert(title: "error", message: "error preparing the audio")
        }
      
        //check Speech recognition availability in user's location/local
        guard let myRecgonition = SFSpeechRecognizer() else {
            showAlert(title: "Error", message: "Recgonization is not allowed in your locatiobn")
            return
        }
        
        //check Speech recognition availability if it is currently in use or free
        if !myRecgonition.isAvailable {
            showAlert(title: "not available", message: "Speech Recognizer is not available please try again later")
        }
        
        //
        
        task = speechReconizer?.recognitionTask(with: request) { (response,error) in
            guard let response = response else {
                if error != nil {
                    showAlert(title: "error", message: error.debugDescription)
                }
                else {
                    showAlert(title: "error", message: "something went wrong with giving a respone")
                }
                
                return
            }
            
            
            //get transcription with the highest confidence level
            var message = response.bestTranscription.formattedString
           // self.lb_speech.text = message
            
            commands = message
            
            
            var lastString: String = ""
                        for segment in response.bestTranscription.segments {
                            let indexTo = message.index(message.startIndex, offsetBy: segment.substringRange.location)
                            lastString = String(message[indexTo...])
                        }
                        
                        if lastString == "next" {
                            imageName = "forward.fill"
                        } else if lastString.elementsEqual("back") {
                            imageName = "backward.fill"
                        } else if lastString.elementsEqual("repeat") {
                            imageName = "repeat"
                        }
            
        }
        
        
        
        
    }
    
    
    func showAlert(title: String, message: String) -> Alert {
        errorTitle = title
        errorMessage = message
        showingError = true
        return Alert(title: Text("Error"), message: Text(message), dismissButton: .cancel())
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
