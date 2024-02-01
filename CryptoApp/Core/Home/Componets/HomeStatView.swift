//
//  HomeStatView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 01/02/24.
//

import SwiftUI

struct HomeStatView: View {
    
    @EnvironmentObject var vm:HomeViewModal
    @Binding var showPortfolio:Bool
    var body: some View {
        HStack(content: {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        })
        .frame(width: UIScreen.main.bounds.width,alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModal())
}
