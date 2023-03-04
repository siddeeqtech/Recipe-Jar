//Sheet to display added recpie details
import SwiftUI
import UIKit



struct RecipeShareSheetScreen: View {
    // var dismiss: (() -> Void)?
    @StateObject private var vm = RecipeViewModelImpl(service: RecipeServiceImpl())
    
    
    // @ObservedObject var model2: Recipe
    @ObservedObject var model: EnvObject //layer to communicate between swiftui sharesheet and uikit webextension
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>//To Dismiss SwiftUI ShareSheet
    
    @State var recURL:String
    
    @State var isErrorPresented = true

    @State var isPresented = true
  
    
    @State var folders = CodeExtensions.sharedDefault.array(forKey: "folders") as? [String] ?? ["folders are empty in web extension"]
    @State var nar = ""
    var body: some View {
        
        NavigationView{
            //based on data state decide which view to show
            switch vm.state {
                
            case .success(let data):
                
                NavigationLink(destination: RecipeImportScreen(data: data, model: model, presentationMode: _presentationMode, recURL: recURL), isActive:$isPresented) {Text("")}
               
                
            case .loading:
                LoadingView(model: model, text: "loading")
                
              
            case .faild(let error):
                
                BlurView
                
                
                    .alert(isPresented: $isErrorPresented){
                        Alert(title: Text("Error"), message: Text(error.localizedDescription), dismissButton: .default(Text("OK")))

                    }
                
            default:
                BlurView
//                    .alert(isPresented: $isErrorPresented){
//                        Alert(title: Text("Error"), message: Text(""), dismissButton: .default(Text("OK")))
//
//                    }

                  
                
             


            }
                
        }
        .navigationBarHidden(true)
           
        
        
        
            .task{
                //await vm.getRecipeTitle()
                await vm.getRecipeDetails(recipeURL: model.recipeURL)
                
                
                
                
                // print("fml \(s)")
            }
            .onDisappear(){//in case sharesheet was swiped down instead of of clicking on canel
                model.cancelAction()//call cancel in UIKit(CustomShareSheet) to tell safari extension we are done
            }
            
            
            
            
            
            
            
            
        
   
        

 
        
        
    }
    
    
    
}




struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeShareSheetScreen( model: EnvObject(),recURL: "")
        
    }
}








struct ViewDidLoadModifier: ViewModifier {
    @State private var viewDidLoad = false
    let action: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if viewDidLoad == false {
                    viewDidLoad = true
                    action?()
                }
            }
    }
}

extension View {
    func onViewDidLoad(perform action: (() -> Void)? = nil) -> some View {
        self.modifier(ViewDidLoadModifier(action: action))
    }
}
