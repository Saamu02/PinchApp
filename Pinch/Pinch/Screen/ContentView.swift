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
    
    private var maxScale: CGFloat = 5
    private var minScale: CGFloat = 1
    
    // MARK: - FUNCTIONS
    
    func resetImageState() {
        
        return withAnimation(.spring) {
            imageScale = minScale
            imageOffset = .zero
        }
    }
    
    // MARK: - CONTENT
    var body: some View {
        
        // MARK: - NAVIGATION STACK
        NavigationStack {
            
            // MARK: - ZSTACK
            ZStack {
                Color.clear
                
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
                        
                        if imageScale == minScale {
                            
                            withAnimation(.spring) {
                                imageScale = maxScale
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
                                
                                if imageScale <= minScale {
                                    resetImageState()
                                }
                            }
                    )
                
                // MARK: - 2. MAGNIFY  GESTURE
                    .gesture(
                        MagnifyGesture()
                         
                            .onChanged { gesture in
                                
                                withAnimation(.linear(duration: 1)) {
                                    
                                    if imageScale >= 1 && imageScale <= 5 {
                                        imageScale = gesture.magnification
                                        
                                    } else if imageScale > 5 {
                                        imageScale = maxScale
                                    }
                                }
                            }
                        
                            .onEnded { _ in
                                
                                withAnimation(.linear(duration: 1)) {
                                    
                                    if imageScale <= 1 {
                                        resetImageState()
                                        
                                    } else if imageScale > 5 {
                                        imageScale = maxScale
                                    }
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
            // MARK: - INFO PANEL
            .overlay(alignment: .top) {
                InfoPanelView(scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
            }
            // MARK: - CONTROLS
            .overlay(alignment: .bottom) {
                
                Group {
                    
                    HStack {
                        
                        // SCALE DOWN
                        Button(action: {
                            
                            withAnimation(.spring) {
                                
                                if imageScale > minScale {
                                    imageScale -= 1
                                    
                                    if imageScale <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                            
                        }) {
                            ControlImageView(systemImage: "minus.magnifyingglass")
                        }
                        
                        // RESET
                        Button(action: {
                            
                            withAnimation(.spring) {
                                
                                if imageScale > minScale {
                                    resetImageState()
                                    
                                } else {
                                    imageScale = maxScale
                                }
                            }
                            
                        }) {
                            ControlImageView(systemImage: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        
                        // SCALE UP
                        Button(action: {
                            
                            withAnimation(.spring) {
                                
                                if imageScale < maxScale {
                                    imageScale += 1
                                    
                                    if imageScale > maxScale {
                                        imageScale = maxScale
                                    }
                                }
                            }
                            
                        }) {
                            ControlImageView(systemImage: "plus.magnifyingglass")
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 12, bottomLeading: 12, bottomTrailing: 12, topTrailing: 12)))
                    .opacity(isAnimating ? 1 : 0)
                }
                .padding(.bottom, 30)
            }
            
        } //: NAVIGATION STACK
    }
}

#Preview {
    ContentView()
}
