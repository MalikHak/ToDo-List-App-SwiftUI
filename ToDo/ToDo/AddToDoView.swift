//
//  AddToDoView.swift
//  ToDo
//
//  Created by Faisal Hakim on 2/24/21.
//

import SwiftUI

struct AddToDoView: View {
 
    @Environment (\.presentationMode) var presentationMode
    
    @State private var name:String = ""
    @State private var priority:String = "Normal"
    
    let priorities = ["high","Normal","low"]
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    
                    TextField("Todo", text:$name)
                    
                    Picker("Priority",selection:$priority){
                        
                        ForEach(priorities, id:\.self){
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                   
                    //Button View
                    
                    Button(action:{
                        print("New ITEM SAVED")
                    }){
                       
                        Text("Save")
                    }
               
                
                
                }
                Spacer()
               
            }
            
            .navigationBarTitle("New To Do",displayMode:.inline)
            .navigationBarItems( trailing: Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            })
            
        }
        
        
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
