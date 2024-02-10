//
//  XMarkButtonView.swift
//  CryptoApp
//
//  Created by Kuldeep Singh on 02/02/24.
//

import SwiftUI

struct XMarkButtonView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

#Preview {
    XMarkButtonView()
}
