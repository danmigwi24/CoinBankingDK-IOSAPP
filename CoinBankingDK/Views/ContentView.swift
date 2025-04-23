//
//  ContentView.swift
//  CoinBankingDK
//
//  Created by Daniel Kimani on 23/04/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var titleText = "Initial Title"
    
    var body: some View {
        ZStack{
            UiCollectionViewControllerRepresentable()
                       .edgesIgnoringSafeArea(.all) // if
        }
    }
    
    var vcSample:some View {
        VStack{
            MyViewControllerRepresentable(title: titleText)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .padding()
                       //.edgesIgnoringSafeArea(.all) // if
            
            TextField("Update Title", text: $titleText)
                          .textFieldStyle(RoundedBorderTextFieldStyle())
                          .padding()
        }
    }
}

#Preview {
    ContentView()
}
