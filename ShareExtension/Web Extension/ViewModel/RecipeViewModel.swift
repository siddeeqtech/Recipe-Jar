//
//  RecipeViewModel.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/11/23.
//Perform any business logic

import Foundation

protocol RecipeViewModel: ObservableObject {
    func getRecipeTitle() async
    func getRecipeDetails(recipeURL:String) async 
}

@MainActor //To perform on main thread in order to update our UI
final class RecipeViewModelImpl: RecipeViewModel {
    enum State {
        case na
        case loading
        case success(data:Recipe)
        case faild(error:Error)
    }
    
    
    @Published private(set) var state: State = .na

    
    
    
    //@published to listen for the updates of this variable
    //private set to be able to change this var only inside this class
    //
    @Published private(set) var recipeTitle: String = "empty"
    @Published private(set) var test: String = "empty"

 //   @Published var recipeObj: Recipe
    @Published var recipeUrl2: String = "empty"

    
    public let service: RecipeService
    
    //Using the protocol not the Implementation = dependency injection
    //injecting our object into this class so any object that conforms to RecipeService protocol can be injected into the viewModel
    //Why not initializing a recipeObject from impl directly?
    //1-if we do that our service will be tied to this class so we wont be able to unit testing the viewModel indep.
    //2-if we have another viewModel that interacts with the same service we need our class to be injectable instead of directly creating an object direcly in this class
    
    init(service:RecipeService) {
        self.service = service
    }
    
    func getRecipeTitle() async {
        do {
            self.recipeTitle = try await service.fetch().name
        } catch {
            //fatalError(error.localizedDescription)
            print("error in fetch: \(error)")
        }
    }
    
    func getRecipeDetails(recipeURL:String) async {
        
//        print("222222222222222222222222222222")
//
        state = .loading
        do {
           var recipe = try await service.fetchRecipe(recipeURL: recipeURL)
            self.state = .success(data: recipe)
//            self.recipeTitle = recipeObj?.name ?? "fml"
//            self.test = recipeObj?.ingredients.first?.name ?? "test"
        } catch  {
            print("error in fetch: \(error)")
            self.state = .faild(error: error)

        }
//
//
        //call postRequest with username and password parameters
//        service.postRequest(recipeURL: recipeURL) { (recipe, error) in
//            if let recipe = recipe {
//
//                DispatchQueue.main.async {
//                    self.recipeObj = recipe
//                }
//
//                   // self.present(controller, animated: true)
//
//
//
//                //print(result)
//
//            } else if let error = error {
//                print("errory: \(error.localizedDescription)")
//            }
//
//
//        }
        
        
    }
    
    
    
 
    
    
}
