//
//  ContentView.swift
//  Pinch
//
//  Created by Ussama Irfan on 22/06/2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES
    
    @State private var isAnimating = false
    @State private var imageScale: CGFloat = 1.0
    @State private var imageOffset = CGSize.zero
    
    // MARK: - FUNCTIONS
    
    func resetImageState() {
        
        return withAnimation(.spring) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    // MARK: - CONTENT
    var body: some View {
        
        // MARK: - NAVIGATION STACK
        NavigationStack {
            
            // MARK: - ZSTACK
            ZStack {
                
                // MARK: - PAGE IMAGE
                Image(ImageConstants.magzineFrontCover)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 10, bottomLeading: 10, bottomTrailing: 10, topTrailing: 10)))
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScale)
                
                // MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        
                        if imageScale == 1 {
                            
                            withAnimation(.spring) {
                                imageScale = 5
                            }
                            
                        } else {
                            resetImageState()
                        }
                    })//: TAP GESTURE
                
                // MARK: - 2. DRAG GESTURE
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                
                                withAnimation(.linear(duration: 1)) {
                                    imageOffset = gesture.translation
                                }
                            }
                            .onEnded { _ in
                                
                                if imageScale <= 1 {
                                    resetImageState()
                                }
                            }
                    )
                
            } //: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                
                withAnimation(.linear(duration: 1)) {
                    isAnimating = true
                }
            })
            
        } //: NAVIGATION STACK
    }
}

#Preview {
    ContentView()
}
