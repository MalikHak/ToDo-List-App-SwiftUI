//
//  EmptyListView.swift
//  ToDo
//
//  Created by Faisal Hakim on 3/2/21.
//

import SwiftUI

struct EmptyListView: View {
    
    @State private var isAnimatedd: Bool = false
    

    var body: some View {
        ZStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20) {
               
                Image("goals").resizable().scaledToFit()
                    .frame(minWidth: 256, idealWidth: 330,
                           minHeight: 56, idealHeight: 230, maxHeight: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).layoutPriority(1)
            
                Text("Manage your to do list ").layoutPriority(0.5).font(.system(.headline,design:.rounded))
            }
        
            .padding(.horizontal)
            .opacity(isAnimatedd ? 1:0)
            .offset(y:isAnimatedd ? 0:-50 )
            .animation(.easeOut(duration:1.5))
            .onAppear(perform: {
                self.isAnimatedd.toggle()
            })
            
            
        }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: 0, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color.gray)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
}

struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
