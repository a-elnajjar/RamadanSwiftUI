//
//  ContentView.swift
//  RamadanSwiftUI
//
//  Created by Abdalla Elnajjar on 2024-03-07.
//




import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Spacer() // Add Spacer to center the views vertically
                
                Circle()
                    .mask(MoonMask(offset: 50).fill(style: FillStyle(eoFill: true)))
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color.yellow)
                    .padding()
                
                Text("Happy Ramadan")
                    .font(.custom("Snell Roundhand", size: 20)) // Set the custom font
                    .foregroundColor(Color(red: 1, green: 0.84, blue: 0)) // Set the color of the text to gold
                    .padding() // Add padding around the text
                
                Spacer() // Add Spacer to center the views vertically
            }
            .alignmentGuide(.top) { _ in
                // Align the VStack to the top
                UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
            }
            
            // Add stars to the background
            ForEach(0..<100) { _ in
                StarView()
            }
        }
    }
}

struct StarView: View {
    @State private var isRotating = false

    var body: some View {
        Image(systemName: "star.fill")
            .foregroundColor(Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)))
            .opacity(0.5)
            .position(
                x: CGFloat.random(in: 0..<UIScreen.main.bounds.width * 3),
                y: CGFloat.random(in: 0..<UIScreen.main.bounds.height * 3)
            )
            .rotationEffect(.degrees(isRotating ? 360 : 0))
            .onAppear() {
                withAnimation(Animation.easeInOut(duration: 5).repeatForever(autoreverses: false)) {
                    isRotating = true
                }
            }
    }
}

struct MoonMask: Shape {
    var offset: CGFloat
    
    func path(in rect: CGRect) -> Path {
        var path = Rectangle().path(in: rect)
        path.addPath(Circle().path(in: rect.inset(by: UIEdgeInsets(top: offset / 2, left: 0, bottom: 0, right: offset / 2))
            .offsetBy(dx: offset, dy: -offset / 2)))
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

