//
//  DetailView.swift
//  memo Watch App
//
//  Created by Tri Pham on 2/18/23.
//

import SwiftUI

struct DetailView: View {
    
    // Property
    
    let note: Note
    let count: Int
    let index: Int
    
    @State private var isCreditPresented: Bool = false
    @State private var isSettingPresented: Bool = false
    
    // Body
    
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            
            HeaderView(title: "")
            
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingPresented) {
                        SettingView()
                    }
                
                Spacer()
                
                Text("\(index+1) / \(count)")
                
                Spacer()
                
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditPresented) {
                        CreditView()
                    }
            } // HStack
            .foregroundColor(.secondary)
            
        } // VStack
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sampleData: Note = Note(id: UUID(), text: "hehe")
    
    static var previews: some View {
        DetailView(note: sampleData, count: 5, index: 1)
    }
}

