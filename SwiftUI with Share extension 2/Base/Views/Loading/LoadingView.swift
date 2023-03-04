//
//  LoadingView.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import SwiftUI

struct LoadingView: View {
    @ObservedObject var model: EnvObject //layer to communicate between swiftui sharesheet and uikit webextension

    @StateObject private var vm = RecipeViewModelImpl(service: RecipeServiceImpl())

    
    let text: String
    var body: some View {
        VStack(spacing: 8) {
            ProgressView()
            Text (text)
            
          
            
        }
        
//        .onAppear{
//            vm.getRecipeDetails(recipeURL: model.recipeURL)
//            //print(model.recipeURL)
//        }
        
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(model: EnvObject(), text: "Fetching Data")
    }
}

