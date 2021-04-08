//
//  WeatherCityDetailView.swift
//  WeatherApp
//
//  Created by Dmytro Pogrebniak on 22.03.2021.
//

import SwiftUI

struct WeatherDetailsView: View {
    
    @Binding var lowerOffset : CGFloat
    @Binding var isChildScrolling : Bool
    
    @EnvironmentObject var viewModel: WeatherMainViewModel
    
    var body: some View {
        CityListView(lowerOffset: $lowerOffset, isChildScrolling: $isChildScrolling, viewModel: viewModel.listViewModel, isNeedAnimation: $viewModel.isAnimationNeeded)
    }
}

struct WeatherCityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailsView(lowerOffset: .constant(10), isChildScrolling: .constant(false))
    }
}
