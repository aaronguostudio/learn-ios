//
//  ContentView.swift
//  SwiftUIStart
//
//  Created by Aaron Guo on 2020-03-24.
//  Copyright © 2020 Aaron Guo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            
            HStack(alignment: .top, spacing: 20) {
                Text("ABC")
                Text("ABC")
                Text("ABC")
                
                Image("icons8-phone-100")
                
                Button(action: {
                    
                }) {
                    Image("icons8-phone-64")
                        .renderingMode(.original)
                }
                
                Spacer()
            }
            
            Spacer()
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

