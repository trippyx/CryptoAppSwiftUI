//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 31/01/24.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText:String
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color.theme.secondaryText)
            
            TextField("Search by name or symbol...", text: $searchText)
                .autocorrectionDisabled(true)
                .foregroundStyle(searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundStyle(Color.theme.accent)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    ,alignment: .trailing
                )
            
        }
        .font(.headline)
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background.opacity(0.15))
                .shadow(color: Color.theme.accent.opacity(0.5), radius: 0, x: 0)
        }
        .padding()
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
