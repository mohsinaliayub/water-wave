//
//  HomeView.swift
//  WaterWave
//
//  Created by Mohsin Ali Ayub on 11.10.23.
//

import SwiftUI

struct HomeView: View {
    @State var progress: CGFloat = 0.5
    @State var startAnimation: CGFloat = 0
    
    var body: some View {
        VStack {
            // MARK: Wave Form
            GeometryReader { proxy in
                let size = proxy.size
                
                // MARK: Water Drop
                ZStack {
                    Image(systemName: "drop.fill")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.white)
                        // Stretching in x-axis
                        .scaleEffect(x: 1.1, y: 1)
                        .offset(y: -1)
                    
                    // Wave Form Shape
                    WaterWave(progress: progress, waveHeight: 0.1, offset: startAnimation)
                        .fill(.blue)
                        // water drops
                        .overlay {
                            ZStack {
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: -20)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 15, height: 15)
                                    .offset(x: 40, y: 30)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 25, height: 25)
                                    .offset(x: -30, y: 80)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 25, height: 25)
                                    .offset(x: 50, y: 70)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: 40, y: 100)
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 10, height: 10)
                                    .offset(x: -40, y: 50)
                            }
                        }
                        // masking into drop shape
                        .mask {
                            Image(systemName: "drop.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding(20)
                        }
                        .overlay(alignment: .bottom) {
                            Button(action: { progress += 0.01 }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 40, weight: .black))
                                    .foregroundStyle(.blue)
                                    .shadow(radius: 2)
                                    .padding(25)
                                    .background(.white, in: Circle())
                            }
                            .offset(y: 40)
                        }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .onAppear {
                    // Looping animation
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        // If you set value less than the rect width it will not finish completely.
//                        startAnimation = size.width - 100
                        startAnimation = size.width
                    }
                }
            }
            .frame(height: 350)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
    }
}

struct WaterWave: Shape {
    var progress: CGFloat
    /// wave height.
    var waveHeight: CGFloat
    /// initial animation start.
    var offset: CGFloat
    
    /// enabling animation
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            // Drawing waves using sine
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                let x: CGFloat = value
                let sine: CGFloat = sin(Angle(degrees: value + offset).radians)
                let y: CGFloat = progressHeight + (height * sine)
                
                path.addLine(to: CGPoint(x: x, y: y))
            }
            
            // Bottom portion
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
        }
    }
}

#Preview {
    HomeView()
}
