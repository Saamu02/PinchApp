//
//  ControlImageView.swift
//  Pinch
//
//  Created by Ussama Irfan on 24/06/2024.
//

import SwiftUI

struct ControlImageView: View {
    
    var systemImage: String
    
    var body: some View {
        Image(systemName: systemImage)
            .font(.system(size: 36))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ControlImageView(systemImage: "minus.magnifyingglass")
        .padding()
}
