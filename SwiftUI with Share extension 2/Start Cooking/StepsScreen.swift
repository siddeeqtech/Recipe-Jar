//
//  ContentView.swift
//  Steps Screen Recipe Jar
//
//  Created by othman shahrouri on 2/5/23.
//

import SwiftUI
import UIKit



struct StepsScreen: View {
    //@Binding var isShowing: Bool
    @State private var currentPage = 0

    
  
    
    @State private var currentIndex = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>//For custom back button
    
    @State private var showPopover = false//for ingredients button
    
    
    @State var ingredients = [Ingredient(title: "Ingredient 1",order:-1),Ingredient(title: "Ingredient 2",order:-1),Ingredient(title: "Ingredient 3",order:-1),Ingredient(title: "Ingredient 4",order:-1),Ingredient(title: "Ingredient 5",order:-1),Ingredient(title: "Ingredient 6",order:-1)]//delete later

    @State var steps = [Step(title: "Heat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food StudiosHeat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food Studios", order: 1),Step(title: "Your pancake will tell you when it's ready to flip. Wait until bubbles start to form on the top and the edges look dry and set. This will usually take about two to three minutes on each side", order: 2),Step(title: "Make a well", order: 3),Step(title: "Store leftover pancakes in an airtight container in the fridge for about a week. Refrain from adding toppings (such as syrup) until right before you serve them so the pancakes don't get soggy.", order: 4)]//delete later
    
    
   // @State step = Step
    
    @State private var showYouTubeModal = false
    
    var body: some View {
        
        NavigationView{
            ZStack{
                //MARK: Steps
                CustomPageView(pageCount: steps.count, currentIndex: $currentPage){
                    ForEach(0..<steps.count) { index in
                       StepView(step: steps[index])
                   }
                }
                .frame(maxWidth: .infinity,maxHeight: 550, alignment: .topLeading)//600 = 0.70422535 of screen height
                
                VStack(spacing: 50){
                    HStack {
                        PageIndicatorView(numberOfPages: steps.count, currentIndex: currentPage)
                    }
                    .padding(.top,420)
                    HStack(spacing: -8){
                        Button{
                            print("back")
                            if currentPage > 0 {
                                currentPage -= 1
                            }
                            
                        } label: {
                            Image("backButton")
                        }
                        
                        Button{
                            print("repeat")
                        } label: {
                            Image("repeatButton")
                        }
                        Button{
                            print("nextButton")
                            if currentPage < steps.count - 1 {
                                currentPage += 1
                            }
                            
                        } label: {
                            Image("nextButton")
                            
                        }
                    }
                   .padding(.bottom,40)
                   
                }
            
            }
            //MARK: navigatin buttons
            .toolbar{
                
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    
                    HStack(spacing:0){
                        //Show ingredients button
                        Button{
                            print("ingredientsButton pressed")
                            showPopover = true
                        } label: {
                            Image("ingredientsButton")
                            
                        }
                        .iOSPopover(isPresented: $showPopover, arrowDirection: .up) {
                          // ViewThatFits{
                                List{
                                    ForEach(ingredients,id: \.title) { ingredient in
                                        HStack{
                                            Image(systemName: "star.fill")
                                                .foregroundColor(.yellow)
                                                .imageScale(.small)
                                            
                                            Text(ingredient.title)
                                        }
                                    }
                                    .listRowSeparator(.hidden)
                                    
                                }
                           // }
                            
                        }
                        
                        //YouTube button
                        Button{
                            print("YouTube button pressed")
                            showYouTubeModal.toggle()
                        } label: {
                            Image("YouTubeButton")
                        }
                        
                        
                        //Text to Speech button
                        Button{
                            print("textToSpeechButton")
                        } label: {
                            Image("textToSpeechButton")
                        }
                        //Voice commands button button
                        Button{
                            print("voiceCommandsButton pressed")
                        } label: {
                            Image("voiceCommandsButton")
                        }
                    }
                    .padding(.horizontal,2)
                    .padding(.top,25)
                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("corssButton")
                            .padding(.top,25)
                    }
                }
                
            }
        }
        .overlay{
            youtubeBlurView
        }
        .animation(.easeInOut, value: showYouTubeModal)
        .transition(.move(edge: .bottom))
      
        //.navigationTitle("")
        .navigationBarBackButtonHidden(true)
        
    }
    
    @ViewBuilder
    var youtubeBlurView: some View {
        if showYouTubeModal {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.5))
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        showYouTubeModal = false
                    }
                
                YouTubeModalView(isShowing: $showYouTubeModal)
                .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .bottom)
            }
            .ignoresSafeArea()
        }
    }
   
}


struct StepScreen_Previews: PreviewProvider {
    static var previews: some View {
        YouTubeModalView(isShowing: .constant(true))
    }
}





