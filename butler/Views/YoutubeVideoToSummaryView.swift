//
//  YoutubeVideoToSummaryView.swift
//  butler
//
//  Created by Manoj on 21/02/24.
//

import SwiftUI

struct YoutubeVideoToSummaryView: View {
    @State private var videoLink = ""
    @State private var summary = ""
    @State private var isLoading = false
    @State private var showAlert = false

    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Enter Youtube link")
                        .font(.title)
                        .padding(.bottom, 30)
                    Spacer()
                }

                TextField("YouTube video link", text: $videoLink)
                    .font(.system(size: 20))
                    .padding(.bottom, 30)

                UniversalButton(buttonText: "Get Summary", buttonAction: {
                    print("Generate button was tapped")

                    if videoLink.isEmpty {
                        showAlert = true
                    } else {
                        Task {
                            do {
                                isLoading = true
                                summary = try await Utility.PostButlerRequest(endPoint: "/generate/youtubesummary", seed: videoLink)
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
                    Text(summary)
                        .padding()
                }

                Spacer()
            }
            .padding(20)
        }
    }
}

#Preview {
    YoutubeVideoToSummaryView()
}
