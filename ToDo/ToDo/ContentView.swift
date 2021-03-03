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
        //Add Button
         .sheet(isPresented: $showingAddTodoView){
            AddToDoView().environment(\.managedObjectContext,self.manageObjectContext)
                                    }
)
        
        if todos.count == 0{
            EmptyListView()
        }
        }
    
    .sheet(isPresented: $showingAddTodoView){
       AddToDoView().environment(\.managedObjectContext,self.manageObjectContext)
                               }
    .overlay(
        ZStack {
            Group{
             
                Circle()
                    .fill(Color.blue)
                    .opacity(0.2)
                    .frame(width: 68, height: 68, alignment: .center)

                Circle()
                    .fill(Color.blue)
                    .opacity(0.15)
                    .frame(width: 90, height: 90, alignment: .center)
                
                             }
            
            Button(action:{
            self.showingAddTodoView.toggle()
        }){
            Image(systemName: "plus.circle.fill")
                .resizable().scaledToFit()
                .background(Circle().fill(Color("ColorBase")))
                .frame(width:48,height: 48,alignment: .center)
            }
        }.padding(.bottom,24)
        .padding(.trailing,24)
        ,alignment: .bottomTrailing)
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
