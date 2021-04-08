//
//  CityListView.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 25.03.2021.
//

import SwiftUI

struct CityListView: View {
    
    @Binding private var lowerOffset : CGFloat
    @Binding private var isViewScrolling : Bool
    
    @Binding private var isNeedAnimation : Bool
    
    @ObservedObject var viewModel : CityListViewModel
    
    private var listOffset : CGFloat = 115
    
    init(lowerOffset: Binding<CGFloat>, isChildScrolling: Binding<Bool>, viewModel: CityListViewModel, isNeedAnimation: Binding<Bool>) {
        self.viewModel = viewModel
        self._lowerOffset = lowerOffset
        self._isViewScrolling = isChildScrolling
        self._isNeedAnimation = isNeedAnimation
    }
    
    var body: some View {
        GeometryReader { gr in
            ZStack {
                textField
                    .zIndex(1)
                list
                    .zIndex(0)
            }
            .padding(.bottom, lowerOffset + listOffset)
        }
    }
    
    var textField : some View {
        VStack(spacing : 0) {
            Text("Location")
                .foregroundColor(.gray)
                .font(.system(size: 16, weight: .medium, design: .default))
                .padding(.all, 28)
            HStack {
                TextField("Enter location", text: $viewModel.filter)
                Button(action: {}, label: {
                    Image("location-ic")
                })
            }
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 9)
            .background(Color.textFieldColor)
            .cornerRadius(4)
            .padding([.leading, .trailing], 30)
            .shadow(color: Color.white.opacity(0.4), radius: 15, x: 0, y: 15)
            .shadow(color: Color.white.opacity(0.7), radius: 8, x: 0, y: 8)
            
            Spacer()
        }
    }
    
    var list : some View {
        ScrollViewReader { sp in
            ScrollView(showsIndicators: false) {
                cities
                    .padding([.leading, .trailing], 35)
                    .onReceive(viewModel.$cities) { _ in
                        guard !viewModel.cities.isEmpty else { return }
                        isNeedAnimation = false
                        sp.scrollTo(viewModel.cities.first!.letter, anchor: .bottom)
                    }
            }
        }
        .gesture(
            DragGesture()
                .onChanged { _ in
                    isViewScrolling = true
                }
                .onEnded{ _ in
                    isViewScrolling = false
                }
        )
        .offset(x: 0, y: listOffset)
    }
    
    var cities : some View {
        LazyVStack(alignment: .leading) {
            ForEach(viewModel.cities, id: \.letter) { letterData in
                VStack(alignment: .leading) {
                    Text(String(letterData.letter))
                        .font(.system(size: 40, weight: .light, design: .default))
                        .foregroundColor(.letterColor)
                        .padding([.top, .bottom], 9)
                    
                    ForEach(letterData.cities, id: \.city) { placeData in
                        Text("\(placeData.city), \(placeData.country)")
                            .font(.system(size: 18, weight: .light, design: .default))
                            .padding([.top, .bottom], 9)
                    }
                }
                .id(letterData.letter)
            }
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(lowerOffset: .constant(0), isChildScrolling: .constant(false), viewModel: CityListViewModel(), isNeedAnimation: .constant(true))
    }
}
