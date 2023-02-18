//
//  CreditView.swift
//  memo Watch App
//
//  Created by Tri Pham on 2/18/23.
//

import SwiftUI

struct CreditView: View {
    var body: some View {
        VStack(spacing: 3) {
            Image("avatar")
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            
            HeaderView(title: "Credit")
            
            Text("Thomas Pham")
                .foregroundColor(.primary)
                .fontWeight(.bold)
            
            Text("For my amazing and beautiful girlfriend, Luong")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                
    
        } // VStack
    }
}

struct CreditView_Previews: PreviewProvider {
    static var previews: some View {
        CreditView()
    }
}
