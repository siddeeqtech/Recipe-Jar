//
//  RecipesFoldersScreen.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//

import SwiftUI

struct RecipesFoldersScreen: View {
    @State var folders = CodeExtensions.sharedDefault.array(forKey: "folders") as? [String] ?? ["folders are empty in web extension"]
    var body: some View {
        VStack {
            List {
                ForEach(folders,id:\.self){folder in
                    Text(folder)
                    
                }
            }
        }
    }
}

struct RecipesFoldersScreen_Previews: PreviewProvider {
    static var previews: some View {
        RecipesFoldersScreen()
    }
}
