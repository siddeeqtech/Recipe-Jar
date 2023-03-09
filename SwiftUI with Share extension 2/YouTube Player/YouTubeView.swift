//
//  YouTubePlayerView.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 2/12/23.
//

import SwiftUI

import SwiftUI
import YouTubePlayerKit
import VisionKit

struct YouTubeView: View {
    
    @State var youTubePlayer = YouTubePlayer(stringLiteral: "https://www.youtube.com/watch?v=QV4_kVIf4V4&ab_channel=iOSAcademy")
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>//For custom back button
    
    @State private var currentIndex = 0
    @State private var sizeOfStep = CGSize()

    @State var steps = [Step(name: "Heat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food StudiosHeat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food Studios", order: 1),Step(name: "Your pancake will tell you when it's ready to flip. Wait until bubbles start to form on the top and the edges look dry and set. This will usually take about two to three minutes on each side", order: 2),Step(name: "Make a well", order: 3),Step(name: "Store leftover pancakes in an airtight container in the fridge for about a week. Refrain from adding toppings (such as syrup) until right before you serve them so the pancakes don't get soggy.", order: 4)]//delete later
    
    
    //    init() {
    //
    //        if #available(iOS 15, *) {
    //                        let navigationBarAppearance = UINavigationBarAppearance()
    //                        navigationBarAppearance.configureWithOpaqueBackground()
    //                        navigationBarAppearance.titleTextAttributes = [
    //                            NSAttributedString.Key.foregroundColor : UIColor(red: 224.0/255, green: 254.0/255, blue: 254.0/255, alpha: 1)
    //                        ]
    //            navigationBarAppearance.backgroundColor =  UIColor(red: 100.0/255, green: 100.0/255, blue: 200.0/255, alpha: 1)
    //            navigationBarAppearance.shadowColor = .clear
    //
    //                        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
    //                        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
    //                        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
    //
    ////                    let tabBarApperance = UITabBarAppearance()
    ////                    tabBarApperance.configureWithOpaqueBackground()
    ////                    tabBarApperance.backgroundColor = UIColor.blue
    ////                    UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
    ////                    UITabBar.appearance().standardAppearance = tabBarApperance
    //                }
    //    }
    
    
    
    var body: some View {
        //ZStack{
        
        VStack(spacing:-10){
            YouTubePlayerView(self.youTubePlayer) { state in
                // Overlay ViewBuilder closure to place an overlay View
                // for the current `YouTubePlayer.State`
                switch state {
                case .idle:
                    ProgressView()
                case .ready:
                    EmptyView()
                case .error(let error):
                    Text(verbatim: "YouTube player couldn't be loaded")
                    
                }
            }
            .aspectRatio(1.75, contentMode: .fit)
            
            
            
            Spacer()

            HStack(spacing:0){
                //MARK: Title Section
                ZStack{

                    Text("Good Old-Fashioned Pancakes")
                        .lineLimit(4)
                        .font(Font.custom("FiraSans-Medium", size: 16))
                        .padding(.leading,8)
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .topLeading)
                    Spacer()
                   VStack(spacing:4){
                        
                        //MARK: Video Source
                        HStack(spacing: 0){
                            Text("YouTube")
                            
                            
                                .foregroundColor(Color(uiColor: UIColor(red: 35.0/255, green: 41.0/255, blue: 70.0/255, alpha: 1)))
                            Text("- RecipeJar")
                            
                                .foregroundColor(.gray)
                                .font(.caption)
                        }
                        
                        
                        .frame(maxWidth: .infinity, maxHeight: 50, alignment: .bottomLeading)
                        
                        Text("Dec 6, 2022")
                            .frame(maxWidth: .infinity, maxHeight: 15, alignment: .bottomLeading)
                        
                            .foregroundColor(.gray)
                            .font(.caption)
                        
                    }
                    .padding(.leading,8)
                    .font(Font.custom("FiraSans-Medium", size: 11))
                 //   Divider()

                }
                .padding(.top,25)
                //.padding(.horizontal, 38)//0.11450382 of screen width

                
                
                Button{
                    print("exit")
                }label: {
                        Image("ExitVideo")
                }
                .padding(.top,60)
                //.padding(.horizontal, 38)//0.11450382 of screen width

                    

                

               //.foregroundColor(CustomColor.navy)
                
                
            }
            .padding(.horizontal, 38)//0.11450382 of screen width

//            .padding(.horizontal, 38)//0.11450382 of screen width

            
            


            Spacer()
           // Divider()
            

            
            //MARK: Steps Section
            VStack(spacing:30) {
                
                VStack{
                    Divider()
                        .padding(.top,45)
                        .frame(width: sizeOfStep.width * 0.78)
                }
                
                CustomPageView(pageCount: steps.count, currentIndex: $currentIndex){
                    ForEach(0..<steps.count) { index in
                        StepView(step: steps[index])
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: 300, alignment: .topLeading)//600 = 0.70422535 of screen height
                .readSize {size in
                    sizeOfStep = size
                    
                }
                .background(.green)
                
                
                
                
                
                VStack{
                    HStack {
                        PageIndicatorView(numberOfPages: steps.count, currentIndex:currentIndex)
                    }
                }
            }
            
            .padding(.bottom,70)
          
            //        .background(.blue)
            //        .frame(maxWidth: .infinity, maxHeight: .infinity)
            //        .ignoresSafeArea(edges:.top)
            .navigationBarBackButtonHidden(true)
            //.navigationBarHidden(true)
            //        .navigationTitle("")
            //        .navigationBarTitleDisplayMode(.inline)
            //.edgesIgnoringSafeArea(.all)
            
            
            
            
            //}
            
            Button{
                self.presentationMode.wrappedValue.dismiss()

            }label: {
                Image("corssButton")
            }
            
        }
        
    }
    //
    //struct YouTubePlayerView_Previews: PreviewProvider {
    //    static var previews: some View {
    //       // YouTubeView()
    //    }
    //}
}


// added this
extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
              .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

extension View {
  func readPosition(onChange: @escaping (CGPoint) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
              .preference(key: PositionPreferenceKey.self, value: geometryProxy.frame(in: CoordinateSpace.global).origin)
      }
    )
    .onPreferenceChange(PositionPreferenceKey.self, perform: onChange)
  }
}

private struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

private struct PositionPreferenceKey: PreferenceKey {
  static var defaultValue: CGPoint = .zero
  static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}
