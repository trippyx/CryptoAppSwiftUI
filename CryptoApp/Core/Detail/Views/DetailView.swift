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
    @State private var showFullDesciption = false
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
            
            VStack(content: {
                ChartView(coin: vm.coin)
                    .padding(.vertical)
                VStack(spacing: 20, content: {
                    overView
                    Divider()
                    desciption
                    overViewGrid
                    additionalView
                    Divider()
                    addtionalViewGrid
                    websiteSection
                })
                .padding()
            })
            
        }
        .navigationTitle(vm.coin.name ?? "")
        .toolbar(content: {
            ToolbarItem(placement:.topBarTrailing) {
                navigationBarTrailingItems
            }
        })
    }
}


extension DetailView{
    
    private var websiteSection:some View{
        VStack(alignment:.leading,spacing:20,content: {
            if let webSiteUrl = vm.webSiteUrl , let url = URL(string: webSiteUrl){
                Link("WebSite", destination: url)
            }
            
            if let redditUrl = vm.redditUrl , let url = URL(string:redditUrl){
                Link("Reddit", destination: url)
            }
            
        })
        .foregroundStyle(.blue)
        .frame(maxWidth: .infinity,alignment:.leading)
        .font(.headline)
    }
    
    private var desciption:some View{
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty{
                
                VStack(alignment:.leading,content: {
                    Text(coinDescription)
                        .lineLimit(showFullDesciption ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button(action: {
                        withAnimation(.smooth) {
                            showFullDesciption.toggle()
                        }
                    }, label: {
                        Text(showFullDesciption ? "Read less ..." : "Read more...")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical,4)
                    })
                    .foregroundStyle(.blue)
                    
                   
                })
                .frame(maxWidth: .infinity,alignment:.leading)
               
            }
        }
    }
    
    var navigationBarTrailingItems:some View{
        HStack(content: {
            Text(vm.coin.symbol?.uppercased() ?? "")
                .font(.subheadline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: vm.coin)
                .frame(width: 25, height: 25)
        })
    }
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
