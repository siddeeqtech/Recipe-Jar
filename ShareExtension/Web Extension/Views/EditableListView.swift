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
    //var id:UUID? {get set}
    var name: String { get  set }
    var orderID: Int { get  set }
    init(name:String,order:Int,quantity:Double,unit:String)
   
}

protocol TitleProtocol2 {
    //var id:UUID? {get set}
    var name: String { get  set }
    var orderID: Int { get  set }
    init(name:String,order:Int)
}



struct EditableListView<Element: TitleProtocol,Element2:TitleProtocol2>: View {
    @State private var elements: [Element] //Genric type for array of objects in this case [Ingredients]
    @State private var elements2: [Element2] // [Steps]
    @State private var editMode = EditMode.active
    @State var itemNameField = String() //TextField to add items for list1
    @State var itemNameField2 = String() //TextField to add items for list2
    @FocusState private var isFocused: Bool

    @State var ingredientQuantityField = 0.0
    @State var ingredientUnitField = String()
    @State var isPresented = false
    @State var isError = false
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    init(items: [Element],items2:[Element2], editMode: EditMode = EditMode.active) {
        _elements = State(initialValue: items)
        _elements2 = State(initialValue: items2)
        
    }
    
    
    var body: some View {
        
        List {
            //MARK: List1 (Ingredients)
            Section("Ingredients") {
                
                ForEach(elements,id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: onDelete)
                .onMove(perform: onMove)
                
                HStack{
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color.green)
                        .font(.system(size: 22))
                        .onTapGesture{
                            //  addItemToElements(cellText: &itemNameTextField, listArray: &elements) // your add item code
                            
                            isPresented = true
                        }
                    
                    
                    TextField("Add new",text: $itemNameField).onTapGesture {
                        isPresented = true

                        //addItemToElements(cellText: &itemNameTextField, listArray: &elements)
                    }
                    
                }
                
            }
            
            //MARK: List2 (STEPS)
            Section("Steps") {
                
                ForEach(elements2,id: \.name) { item in
                    Text(item.name)
                }
                .onDelete(perform: onDelete2)
                .onMove(perform: onMove2)
                
                HStack{
                    Image(systemName: "plus.circle.fill")
                    
                        .foregroundColor(.green)
                    
                        .font(.system(size: 22))
                        .onTapGesture{
                            if !itemNameField2.isEmpty{
                                addItemToElements2(cellText: &itemNameField2, listArray: &elements2) // your add item code
                            }
                            else {
                               // itemNameField2.edit
                                isFocused = true
                            }
                        }
                    
                    TextField("Add new",text: $itemNameField2)
                        .focused($isFocused)

                        
                        .onSubmit {
                        addItemToElements2(cellText: &itemNameField2, listArray: &elements2) // your add item code
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
        //MARK: Alerts
        .alert("Add ingredient",isPresented: $isPresented) {
            TextField("Ingredient Name", text: $itemNameField)
            TextField("Ingredient Quantity", value: $ingredientQuantityField, formatter: numberFormatter)
                .keyboardType(.decimalPad)
            TextField("Ingredient Unit", text: $ingredientUnitField)
            Button("Add"){
                addItemToElements(cellText: &itemNameField, ingredientQuantity: ingredientQuantityField, ingredientUnit: ingredientUnitField, listArray: &elements)
            }
            Button("Cancel", role: .cancel) {
               resetFields()
            }
        }
        
        .alert(isPresented: $isError) {
            Alert(title: Text("Error"), message: Text("Make sure to enter the ingredient name, quantity and unit"), dismissButton: .default(Text("OK"),action: resetFields))
        }
        
        
        
        
        
        
       .environment(\.editMode, $editMode)//sets a list always in edit mode
        
        
        
    }
    
    private func resetFields(){
        itemNameField = ""
        ingredientQuantityField = 0
        ingredientUnitField = ""
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
    
    
    private func addItemToElements(cellText: inout String,ingredientQuantity:Double,ingredientUnit:String,listArray: inout [Element]) {
        if !cellText.isEmpty && ingredientQuantity != 0 && !ingredientUnit.isEmpty {
            //add ingredient to list of ingredients
            listArray.append(Element(name: cellText,order: -1,quantity: ingredientQuantity,unit: ingredientUnit))
            //cellText = ""
        }
        else{
            isError = true
        }
    }
    
    private func addItemToElements2(cellText: inout String,listArray: inout [Element2]) {
        if !cellText.isEmpty {
            //add step to list of steps
            listArray.append(Element2(name: cellText, order: -1))
            cellText = ""
        }
    }
    
}





