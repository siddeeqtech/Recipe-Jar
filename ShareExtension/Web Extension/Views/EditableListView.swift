//
//  List.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 1/31/23.

//A view that takes two arrays of objects that conforms to the TitleProtocol displaying each array of objects in an editable secition

import Foundation
import SwiftUI
import MobileCoreServices

//A protocol that force struts to have a title property to be disblayed in the EditableList with an id to make sure the forEach works properly
protocol TitleProtocol {
    var id:UUID {get set}
    var title: String { get  set }
    var order: Int { get  set }
    init(title:String,order:Int)
}
struct EditableListView<Element: TitleProtocol,Element2:TitleProtocol>: View {
    @State private var elements: [Element] //Genric type for array of objects in this case [Ingredients]
    @State private var elements2: [Element2] // [Steps]
    @State private var editMode = EditMode.active
    @State var itemNameTextField = String() //TextField to add items for list1
    @State var itemNameTextField2 = String() //TextField to add items for list2

    init(items: [Element],items2:[Element2], editMode: EditMode = EditMode.active) {
        _elements = State(initialValue: items)
        _elements2 = State(initialValue: items2)
      
    }
    var body: some View {
      
            List {
                
                Section("Ingredients") {
                   
                    ForEach(elements,id: \.id) { item in
                        Text(item.title)
                    }
                    .onDelete(perform: onDelete)
                    .onMove(perform: onMove)
                    
                    HStack{
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(Color.green)
                            .font(.system(size: 22))
                            .onTapGesture(count: 1, perform: {
                                addItemToElements(cellText: &itemNameTextField, listArray: &elements) // your add item code
                                })
                        TextField("Add new",text: $itemNameTextField).onSubmit {
                            
                            addItemToElements(cellText: &itemNameTextField, listArray: &elements)
                        }
                 
                    }
              
                }
                
                
                Section("Steps") {
                  
                    ForEach(elements2,id: \.id) { item in
                        Text(item.title)
                    }
                    .onDelete(perform: onDelete2)
                    .onMove(perform: onMove2)
                    
                    HStack{
                        Image(systemName: "plus.circle.fill")
                     
                            .foregroundColor(.green)
                                                
                             .font(.system(size: 22))
                             .onTapGesture(count: 1, perform: {
                                 addItemToElements2(cellText: &itemNameTextField2, listArray: &elements2) // your add item code
                                 })
                    
                        TextField("Add new",text: $itemNameTextField2).onSubmit {
                            addItemToElements2(cellText: &itemNameTextField2, listArray: &elements2) // your add item code
                        }
                    }
                }
                //MARK: Choose Recipe folder
                NavigationLink {
                    RecipesFoldersScreen()
                } label: {
        
                        HStack{
                            Text("Folder")
                                .fontWeight(.bold)
                            Text("None")
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .foregroundColor(Color.gray)
                        }
       
                    
                }
             
                
                
            }
            .environment(\.editMode, $editMode)
        
        
        
    }
    private func onDelete(offsets: IndexSet) {
        elements.remove(atOffsets: offsets)
    }
    
    private func onMove(source: IndexSet, destination: Int) {
        elements.move(fromOffsets: source, toOffset: destination)
    }
    private func onDelete2(offsets: IndexSet) {
        elements2.remove(atOffsets: offsets)
    }
    
    private func onMove2(source: IndexSet, destination: Int) {
        elements2.move(fromOffsets: source, toOffset: destination)
    }
    

    private func addItemToElements(cellText: inout String,listArray: inout [Element]) {
        if !cellText.isEmpty {
            //add ingredient to list of ingredients
            listArray.append(Element(title: cellText,order: -1))
            cellText = ""
        }
    }
    
    private func addItemToElements2(cellText: inout String,listArray: inout [Element2]) {
        if !cellText.isEmpty {
            //add ingredient to list of ingredients
            listArray.append(Element2(title: cellText, order: -1))
            cellText = ""
        }
    }
    
}





