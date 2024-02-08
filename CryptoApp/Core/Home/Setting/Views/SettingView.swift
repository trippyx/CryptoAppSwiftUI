//
//  SettingView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 08/02/24.
//

import SwiftUI

struct SettingView: View {
    let defaultUrl = URL(string: "https://google.com")!
    let youtubeUrl = URL(string: "https://youtube.com")!
    let coffeeUrl = URL(string: "https://linkdin.com")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    let personalURL = URL(string: "https://www.nicksarno.com")!
    var body: some View {
        NavigationStack {
            List{
                thinkingView
                coinGekoSection
                develoeprSection
                applicationSection

            }
            .font(.headline)
            .foregroundStyle(.blue)
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButtonView()
                }
            })
        }
    }
}

extension SettingView{
    var thinkingView:some View{
        Section {
            VStack(alignment:.leading,content: {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @Swift course")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding(.vertical)
        
            Link("Subscibe", destination: youtubeUrl)
            Link("Support his coffee addiction", destination: coffeeUrl)
            
        } header: {
            Text("Test")
        }
    }
    
    var coinGekoSection:some View{
        Section {
            VStack(alignment:.leading,content: {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This data is coming from a free api coinGeko")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding(.vertical)
        
            Link("Subscibe", destination: youtubeUrl)
            Link("Support his coffee addiction", destination: coingeckoURL)
            
        } header: {
            Text("Test")
        }
    }
    
    var develoeprSection:some View{
        Section {
            VStack(alignment:.leading,content: {
                Image("logo")
                    .resizable()
                    .frame(width:100,height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app is developed by Kuldeep Singh in swiftui")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            })
            .padding(.vertical)
        
            Link("Subscibe", destination: youtubeUrl)
            Link("Support his coffee addiction", destination: personalURL)
            
        } header: {
            Text("Test")
        }
    }
    
    var applicationSection:some View{
        Section {
            Link("Terms of Service", destination: defaultUrl )
            Link("Privacy Policy", destination: defaultUrl )
            Link("Company Website", destination: defaultUrl )
            Link("Learn more", destination: defaultUrl )
        } header: {
            Text("Application")
        }
    }
    
    
}

#Preview {
    SettingView()
}
