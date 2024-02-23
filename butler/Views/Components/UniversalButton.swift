//
//  UniversalButton.swift
//  butler
//
//  Created by Manoj on 20/02/24.
//

import SwiftUI

struct UniversalButton: View {
    var buttonText: String
    var buttonAction: () -> Void
    
    var body: some View {
        #if os(iOS)
            HStack {
                Button(action: buttonAction) {
                    Text(buttonText)
                        .cornerRadius(10)
                        .padding(.horizontal, 100)
                        .padding(.vertical)
                }
                .background(.indigo)
                .foregroundColor(.white)
                .cornerRadius(10)
                Spacer()
            }
        #elseif os(macOS)
            HStack {
                Button(action: buttonAction) {
                    Text(buttonText)
                }
                Spacer()
            }
        #endif
    }
}

#Preview {
    UniversalButton(buttonText: "Generate", buttonAction: {
        print("Generate button was tapped")
    })
}
