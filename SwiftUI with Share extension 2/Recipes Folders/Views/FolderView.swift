//
//  FolderView.swift
//  Whisk
//
//  Created by Nedine on 2/8/23.
//

import SwiftUI

struct FolderView: View {
    @State var folder: Folder
//    let index = folder.firstIndex(of: folder)!
    var body: some View {
        VStack(alignment: .leading, spacing:2) {
           
            
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image("dots2")
                }
               
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            HStack(spacing: 12) {
                

                StrokeText(text: "\(folder.index)", width: 0.5, color: Color("purple"))
                           .foregroundColor(Color("yellow"))
                           .font(.system(size: 18, weight: .bold))
                
                Text(folder.name)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                

            }
            .padding(.horizontal)
            .padding(.bottom, 4)
            .offset(y: -8)
            
            Rectangle()
                .fill(Color("lightgrey").opacity(0.5))
                .frame(width: 59,height: 1)
                .padding(.horizontal)
                .padding(.bottom, 2)
            
//            Divider()
//                .background(Color("lightgrey"))
//                .frame(maxWidth: 59)
//                .padding(.horizontal)
//                .padding(.bottom, 4)
            
            
            
            Text("\(folder.numOfRecipe) recipes")
                .font(.system(size: 10))
                .foregroundColor(Color("lightgrey"))
                .padding(.horizontal)
                .padding(.bottom, 10)
            
         
                
        }
        .frame(width: 144, height: 79)
        .background(Color("grey"))
        .clipShape(RoundedRectangle(cornerRadius: 9))
        
        .overlay(
            RoundedRectangle(cornerRadius: 9)
                .strokeBorder(Color("purple"), lineWidth: 2)
            
        )
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView(folder: Folder(name: "Lunch", index: 1))
    }
}
