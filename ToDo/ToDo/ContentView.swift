//
//  ContentView.swift
//  ToDo
//
//  Created by Faisal Hakim on 2/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(entity: TodoTask.entity(), sortDescriptors: [NSSortDescriptor(keyPath:\TodoTask.name, ascending:true )]) var todos:FetchedResults<TodoTask>
    
    
    @Environment(\.managedObjectContext) var manageObjectContext;
    @State private var showingAddTodoView:Bool = false
    var body: some View {
       

 NavigationView{
    
     ZStack {
        List{
        ForEach(self.todos,id:\.self){todo in
            
        HStack{
        Text(todo.name ?? "UNKNOWN")
        
        Spacer()
        
            Text(todo.priority ?? "UNKNOWN")
            }
            
        }.onDelete(perform: deleteTodo)
   
        }
    .navigationBarTitle("ToDo",displayMode: .inline).navigationBarItems(leading: EditButton(),trailing:
       
    Button(action:{
    //show add to do view here
    self.showingAddTodoView.toggle()                                }){
     Image(systemName: "plus")
     }
         .sheet(isPresented: $showingAddTodoView){
           
             AddToDoView().environment(\.managedObjectContext,self.manageObjectContext)
                                    }
          )
        if todos.count == 0{
            EmptyListView()
        }
    }
        } 
    }
    
    private func deleteTodo(at offsets:IndexSet){
        for index in offsets{
            
            let todo = todos[index]
            
            manageObjectContext.delete(todo)
            do{
                try manageObjectContext.save()
            }catch{
               print(error)
            }
        }
        sheet(isPresented: $showingAddTodoView){
           
             AddToDoView().environment(\.managedObjectContext,self.manageObjectContext)
                                    }
    }
}

struct ContentView_Previews: PreviewProvider {
  
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate)
        .persistentContainer.viewContext
          
       return ContentView()
       .environment(\.managedObjectContext, context)
        
    }
}
