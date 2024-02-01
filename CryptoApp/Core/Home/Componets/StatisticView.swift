//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 01/02/24.
//

import SwiftUI

struct StatisticView: View {
    let stat:StaticsModal
    var body: some View {
        VStack(alignment:.leading,spacing:4,content: {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            HStack(content: {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: stat.percentageChange ?? 0 >= 0 ? 0 : 180))
                Text(stat.percentageChange?.asPercantageString() ?? "")
                    .font(.caption)
                    .bold()
            })
            .foregroundStyle((stat.percentageChange ?? 0 >= 0 ? Color.theme.green : Color.theme.red))
            .opacity(stat.percentageChange == nil ? 0.0 : 1.0)
            
        })
    }
}

#Preview {
    StatisticView(stat: DeveloperPreview.shared.stat3)
}
