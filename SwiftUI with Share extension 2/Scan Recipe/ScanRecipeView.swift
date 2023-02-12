//
//  ScanRecipe.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 11/3/22.
//

import SwiftUI

struct ScanRecipeView: View {
    
    @State private var showScannerSheet = false
    //array of scanned data
    @State private var texts = [scanRecipeData]()
    var body: some View {
        
        
        
        
        NavigationView{
            VStack(spacing: 0){
                //if scanned array not empty create a list
                if texts.count > 0 {
                    List{
                        ForEach(texts){ text1 in
                            NavigationLink(
                                destination: ScrollView{Text(text1.content)}
                                , label: {Text(text1.content).lineLimit(1)})
                            
                        }
                    }
                    
                } else{ Text("No scan yet").font(.title)}
                
            }
            .navigationTitle("Scan OCR")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button{
                showScannerSheet.toggle()
                
            } label: {
                Image(systemName: "doc.text.viewfinder")
                    .font(.title)
            }
                .sheet(isPresented: $showScannerSheet){}
                                
                                
                                
                                
            )
            
        }
        
        
        
        
        
    }
}

struct ScanRecipe_Previews: PreviewProvider {
    static var previews: some View {
        ScanRecipeView()
    }
}
