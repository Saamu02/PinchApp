//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Ussama Irfan on 24/06/2024.
//

import SwiftUI

struct InfoPanelView: View {
    
    var scale: CGFloat
    var offset: CGSize
    
    @State private var isInfoPanelVisible = false
    
    var body: some View {
        
        HStack {
            
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1) {
                    isInfoPanelVisible.toggle()
                }
            
            Spacer()
            
            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offset.width)")
                
                Spacer()

                Image(systemName: "arrow.up.and.down") 
                Text("\(offset.height)")
                
                Spacer()
            }
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 8, bottomLeading: 8, bottomTrailing: 8, topTrailing: 8)))
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0)
            .animation(.easeOut, value: isInfoPanelVisible)
            
            Spacer()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    InfoPanelView(scale: 1, offset: .zero)
        .padding()
}
