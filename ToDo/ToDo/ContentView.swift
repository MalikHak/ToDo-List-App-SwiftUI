//
//  ContentView.swift
//  ToDo
//
//  Created by Faisal Hakim on 2/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddTodoView:Bool = false
    var body: some View {
       

 NavigationView{
List(0..<5){item in
  
Text("Hello Team")
}
.navigationBarTitle("ToDo",displayMode: .inline).navigationBarItems(trailing:
Button(action:{
//show add to do view here
self.showingAddTodoView.toggle()                                }){
 Image(systemName: "plus")
 }
     .sheet(isPresented: $showingAddTodoView){
       AddToDoView()
                                }
            )
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
