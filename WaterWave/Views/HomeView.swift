//
//  HomeView.swift
//  WaterWave
//
//  Created by Mohsin Ali Ayub on 11.10.23.
//

import SwiftUI

struct HomeView: View {
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
                    
                    // Wave Form Shape
                    WaterWave(progress: 0.5, waveHeight: 0.1)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 350)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
    }
}

struct WaterWave: Shape {
    var progress: CGFloat
    var waveHeight: CGFloat
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            
            // Drawing waves using sine
            let progressHeight: CGFloat = (1 - progress) * rect.height
            let height = waveHeight * rect.height
            
            for value in stride(from: 0, to: rect.width, by: 2) {
                let x: CGFloat = value
                let sine: CGFloat = sin(value)
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
