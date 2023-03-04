//
//  RecipeImportScreen.swift
//  Recipe Jar
//
//  Created by othman shahrouri on 3/3/23.
//

import SwiftUI

struct RecipeImportScreen: View {
    
     var data:Recipe!
    

    @ObservedObject var model: EnvObject //layer to communicate between swiftui sharesheet and uikit webextension
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>//To Dismiss SwiftUI ShareSheet
    @State var recURL:String
    var body: some View {
        
      
            ZStack{//main zstack
                
                VStack(spacing: 0){
                    //MARK: Recipe image
                    VStack(spacing:0){
                        RecipeImageView(imageName: "paleo-pancakes")
                        //.background(Color.yellow)
                    }
                    
                    //MARK: Recipe Title
                    HStack(spacing: 0){
                        Text(data.name)
                           .font(Font.custom("FiraSans-Medium", size: 20))
                            .foregroundColor(CustomColor.navy)
                            .padding(.top, 65)
                            .padding(.bottom, 10)
                    }
                 
                    //MARK: Prep and serving info
                    HStack(spacing:40){
                        
                        HStack{
                            Text("Prep time")
                                .foregroundColor(CustomColor.navy)
                            
                            Text("10")
                                .foregroundColor(CustomColor.yellow)
                                .font(Font.custom("FiraSans-Medium", size: 20))
                        }
                        
                        HStack{
                            Text("Servings")
                                .foregroundColor(CustomColor.navy)
                            Text("1")
                                .foregroundColor(CustomColor.yellow)
                                .font(Font.custom("FiraSans-Medium", size: 20))
                        }
                        
                    }
                    .font(Font.custom("FiraSans-Medium", size: 15))
                    //.padding(5)
                    //MARK: List Ingredients & Steps
                    VStack{
                        EditableListView(items:  data.ingredients, items2: data.steps)
                    }
                    .padding(.top,15)
                    
                }
            }
        
            .background(Color.init(uiColor: UIColor(red: 240/255, green: 240/255, blue: 246/255, alpha: 1)))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        model.cancelAction()//calling a UIKit function to tell Web Extension to return user to Safari after canceling
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        model.doneAction()//calling a UIKit function to tell Web Extension to return user to Safari after saving
                        print("Save tapped!")
                    }
                }
            }
            .navigationTitle("Edit Recipe")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
       }
   
    
}

struct RecipeImportScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecipeImportScreen(model: EnvObject(),recURL: "")
    }
}
