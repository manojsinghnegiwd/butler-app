//
//  GenerateIdeasView.swift
//  butler
//
//  Created by Manoj on 19/02/24.
//

import SwiftUI

struct GenerateIdeasView: View {
    @State private var text = ""
    @State private var response = ""
    @State private var isLoading = false
    @State private var showAlert = false

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("What do you want to generate ideas for?")
                        .font(.title)
                        .padding(.bottom, 10)
                    Spacer()
                }
                TextEditor(text: $text)
                    .font(.system(size: 20))
                    .padding()
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .background()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.accentColor, lineWidth: 3))
                    .frame(minHeight: 200, maxHeight: 200)
                    .padding(.bottom, 10)

                UniversalButton(buttonText: "Generate", buttonAction: {
                    print("Generate button was tapped")

                    if text.isEmpty {
                        showAlert = true
                    } else {
                        Task {
                            do {
                                isLoading = true
                                response = try await Utility.PostButlerRequest(endPoint: "/generate/ideas", seed: text)
                                isLoading = false
                            } catch {
                                print("Failed to make request: \(error)")
                                isLoading = false
                            }
                        }
                    }
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Text cannot be empty"), dismissButton: .default(Text("OK")))
                }

                if isLoading {
                    ProgressView()
                } else {
                    Text(response)
                        .padding()
                }

                Spacer()
            }
            .padding(20)
        }
    }
}

struct ResponseData: Codable {
    let response: String
}

#Preview {
    GenerateIdeasView()
}
