//
//  AddToDoView.swift
//  ToDo
//
//  Created by Faisal Hakim on 2/24/21.
//

import SwiftUI

struct AddToDoView: View {
 
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment (\.presentationMode) var presentationMode
    
    @State  private var errorShowing:Bool=false
    @State private var errorTitle:String = ""
    @State private var errorMessage:String = ""
    
    @State private var name:String = ""
    @State private var priority:String = "Normal"
    
    let priorities = ["high","Normal","low"]
    
    var body: some View {
        NavigationView{
            VStack{
                VStack(alignment: .leading, spacing: 20){
                    
                    TextField("Todo", text:$name).padding()
                        .background(Color(UIColor.tertiarySystemFill))
                        .cornerRadius(9.0)
                        .font(.system(size:24,weight:.bold,design:.default))
                    
                    Picker("Priority",selection:$priority){
                        
                        ForEach(priorities, id:\.self){
                            Text($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    
                   
                    //Button View
                    
                    Button(action:{
                print("ssddfff")
                        
                  
                        if self.name != "" {
                            let todo = TodoTask(context:self.managedObjectContext)

                                                  todo.name = self.name
                                                  todo.priority = self.priority

                                                  do{
                                                      try self.managedObjectContext.save()

                                                    print("New todo: \(todo.name ?? ""), priority:\(todo.priority ?? "")")

                                                  }catch{
                                                   print(error)
                                                  }

                        }else{
                            
                            self.errorShowing = true
                            self.errorMessage = "Please enter a task name"
                            self.errorTitle = "Invalid Name"
                            return
                        }

                        self.presentationMode.wrappedValue.dismiss()
                        
                        
                        
                    }){
                       
                        Text("Save")
                        
                            .font(.system(size: 24,weight:.bold,design:.default)).padding()
                            .frame(minWidth:0,maxWidth: .infinity)
                            .background(Color.blue)

                            .cornerRadius(9.0)
                            .foregroundColor(Color.white)

                    }
               
                
                
                }.padding(.horizontal)
                .padding(.vertical,30)
                Spacer()
               
            }
            
            .navigationBarTitle("New To Do",displayMode:.inline)
            .navigationBarItems( trailing: Button(action:{
                self.presentationMode.wrappedValue.dismiss()
            }){
                Image(systemName: "xmark")
            }).alert(isPresented: $errorShowing){
                Alert(title:Text(errorTitle),message:Text(errorMessage),dismissButton:.default(Text("OK")))
            }
            
        }
        
        
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView()
    }
}
