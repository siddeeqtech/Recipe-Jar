//
//  RecipeViewModel.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/11/23.
//Perform any business logic

import Foundation

protocol RecipeViewModel: ObservableObject {
    func getRecipeTitle() async
}

@MainActor //To perform on main thread in order to update our UI
final class RecipeViewModelImpl: RecipeViewModel {
    //@published to listen for the updates of this variable
    //private set to be able to change this var only inside this class
    //
    @Published private(set) var recipeTitle: String = ""
    private let service: RecipeService
    
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
            self.recipeTitle = try await service.fetch()
        } catch {
            print(error)
        }
    }
    
}
