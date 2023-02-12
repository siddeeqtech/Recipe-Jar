//Sheet to display added recpie details
import SwiftUI
import UIKit



struct RecipeDetailsScreen: View {
    var dismiss: (() -> Void)?
    //@StateObject private var vm = RecipeViewModelImpl(service: RecipeServiceImpl())
    
    @ObservedObject var model: EnvObject
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var isPresented = false

    @State var ingredients = [Ingredient(title: "Ingredient 1",order:-1),Ingredient(title: "Ingredient 2",order:-1),Ingredient(title: "Ingredient 3",order:-1),Ingredient(title: "Ingredient 4",order:-1),Ingredient(title: "Ingredient 5",order:-1),Ingredient(title: "Ingredient 6",order:-1)]//delete later
    @State var steps = [Step(title: "Heat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food StudiosHeat a lightly oiled griddle or pan over medium-high heat. Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake; cook until bubbles form and the edges are dry, about 2 to 3 minutes. Flip and cook until browned on the other side. Repeat with remaining batter. Dotdash Meredith Food Studios", order: 1),Step(title: "Your pancake will tell you when it's ready to flip. Wait until bubbles start to form on the top and the edges look dry and set. This will usually take about two to three minutes on each side", order: 2),Step(title: "Make a well", order: 3),Step(title: "Store leftover pancakes in an airtight container in the fridge for about a week. Refrain from adding toppings (such as syrup) until right before you serve them so the pancakes don't get soggy.", order: 4)]//delete later
    
    @State var folders = CodeExtensions.sharedDefault.array(forKey: "folders") as? [String] ?? ["folders are empty in web extension"]
    @State var nar = ""
    var body: some View {
        NavigationView {
             ZStack{//main zstack
                   VStack(spacing: 0){
                    //MARK: Recipe image
                    VStack(spacing:0){
                   RecipeImageView(imageName: "paleo-pancakes")
                            //.background(Color.yellow)
                    }
  
                       //MARK: Recipe Title
                    HStack(spacing: 0){
                        Text("Good Old-Fashioned Pancakes")
                        //.fontWeight(.thin)
                            .font(Font.custom("FiraSans-Medium", size: 20))
                            .foregroundColor(CustomColor.navy)
                           // .fixedSize(horizontal: true, vertical: false)
//
                            .padding(.top, 65)
                            .padding(.bottom, 10)
                    }
                       
                       
//                    .task {
//                        await vm.getRecipeTitle()
//                    }
                    
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
                            EditableListView(items: ingredients, items2: steps)
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
      
        }
        .onDisappear(){//in case sharesheet was swiped down instead of of clicking on canel
            model.cancelAction()//call cancel in UIKit(CustomShareSheet) to tell safari extension we are done
        }

    }
    
    
 
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsScreen( model: EnvObject(myvar: ""))

    }
}







