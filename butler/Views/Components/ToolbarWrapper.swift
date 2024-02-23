//
//  ToolbarWrapper.swift
//  butler
//
//  Created by Manoj on 21/02/24.
//

import SwiftUI

struct ToolbarWrapper<Content: View>: View {
    var title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        content
            .navigationTitle("")
            .toolbar {
                #if os(iOS)
                    ToolbarItem(placement: .principal) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            print(title)
                        }) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                #elseif os(macOS)
                    ToolbarItem(placement: .navigation) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button(action: {
                            print(title)
                        }) {
                            Image(systemName: "square.and.arrow.up")
                        }
                    }
                #endif
        }
    }
}
#Preview {
    ToolbarWrapper(title: "Demo Title") {
        Text("Demo Text")
    }
}
