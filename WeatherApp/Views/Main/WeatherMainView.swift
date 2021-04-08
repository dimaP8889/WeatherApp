//
//  ContentView.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 22.03.2021.
//

import SwiftUI

struct WeatherMainView: View {
    
    @State private var offset : CGFloat = 270
    @State private var isChildScrolling = false
    
    @StateObject var viewModel = WeatherMainViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                GeometryReader { geometry in
                    Image("day")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: geometry.size.width, maxHeight: 300)
                    Spacer()
                }
            }
            VStack {
                Group {
                    Spacer()
                    WeatherDetailsView(lowerOffset: $offset, isChildScrolling: $isChildScrolling)
                        .environmentObject(viewModel)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.2), radius: 40, x: 0, y: 16)
                        .gesture(
                            DragGesture()
                                .onChanged{ gesture in
                                    guard !isChildScrolling else { return }
                                    countOffset(translation: gesture.translation.height)
                                }
                                .onEnded{ gesture in
                                    viewModel.isAnimationNeeded = true
                                    self.offset = gesture.translation.height < 0 ? 30 : 270
                                }
                        )

                }
                .offset(x: 0, y: offset)
            }
            .animation(
                viewModel.isAnimationNeeded ?
                    .interpolatingSpring(
                        mass: 1.0,
                        stiffness: 100.0,
                        damping: 12,
                        initialVelocity: 5
                    ) : nil
            )
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: - Private
private extension WeatherMainView {
    
    func countOffset(translation : CGFloat) {
    
        let currentOffset = self.offset + translation
        self.offset = currentOffset > 270 ? 270.0 :
            currentOffset < 30 ? 30.0 : currentOffset
        viewModel.isAnimationNeeded = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherMainView()
            .previewDevice("iPhone 12 Pro Max")
            
    }
}
