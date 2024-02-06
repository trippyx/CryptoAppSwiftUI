//
//  DetailView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 04/02/24.
//

import SwiftUI


struct DetailLoadingView:View {
    @Binding var coin:CoinModel?
    var body: some View {
        ZStack {
            if let coin = coin{
                DetailView(coin: coin)
            }
        }
    }
}


struct DetailView: View {
    @StateObject var vm : DetailViewModal
    
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let spacing : CGFloat = 30
    
    init(coin:CoinModel) {
        _vm = StateObject(wrappedValue:  DetailViewModal(coin: coin))
    }
    var body: some View {
        ScrollView {
            VStack(spacing: 20, content: {
                Text("")
                    .frame(height: 150)
                overView
                Divider()
                overViewGrid
                additionalView
                Divider()
                addtionalViewGrid
            })
            .padding()
        }
        .navigationTitle(vm.coin.name ?? "")
    }
}


extension DetailView{
    var overView:some View{
        Text("OverView")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    var additionalView:some View{
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    var overViewGrid:some View{
        LazyVGrid(columns: columns,alignment: .leading,spacing: spacing,pinnedViews: [], content: {
            ForEach(vm.overViewStatics) { stat in
               StatisticView(stat: stat)
            }
        })
    }
    
    var addtionalViewGrid:some View{
        LazyVGrid(columns: columns,alignment: .leading,spacing: spacing,pinnedViews: [], content: {
            ForEach(vm.additionalStatics) { stat in
                StatisticView(stat:stat)
            }
        })
    }
    
    
}


#Preview {
    NavigationStack {
        DetailView(coin: DeveloperPreview.shared.coin)
    }
   
}
