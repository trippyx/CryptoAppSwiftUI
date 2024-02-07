//
//  ChartView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 07/02/24.
//

import SwiftUI

struct ChartView: View {
    private let data:[Double]
    private let maxY:Double
    private let minY:Double
    private let lineColor:Color
    private let startingDate:Date
    private let endingDate:Date
    @State private var pecentage : CGFloat = 0
    init(coin:CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    var body: some View {
        VStack(content: {
            chartView
                .frame(height: 200)
                .background(chartBackGround)
                .overlay (chartYAxis.padding(.horizontal,4),alignment: .leading)
           chartDateLabel
                .padding(.horizontal,4)
        })
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
                withAnimation(.linear(duration: 2.0)){
                    pecentage = 1.0
                }
            })
           
        })
    }
}


extension ChartView{
    
    private var chartDateLabel:some View{
        HStack(content: {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        })
    }
    
    private var chartYAxis:some View{
        VStack(content: {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        })
    }
    private var chartBackGround:some View{
        VStack(content: {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        })
    }
    
    private var chartView:some View{
        GeometryReader { geometry in
            Path{ path in
                for index in data.indices{
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY)/yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: pecentage)
            .stroke(lineColor,style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color:lineColor, radius: 10, x: 0.0, y: 10.0)
            .shadow(color:lineColor.opacity(0.5), radius: 10, x: 0.0, y: 20.0)
            .shadow(color:lineColor.opacity(0.2), radius: 10, x: 0.0, y: 30.0)
            .shadow(color:lineColor.opacity(0.1), radius: 10, x: 0.0, y: 40.0)
            
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.shared.coin)
}
