//
//  ContentView.swift
//  butler
//
//  Created by Manoj on 19/02/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedSidebarItem: String? = nil
    @State private var isExpanded: Bool = true
    @State private var preferredColumn = NavigationSplitViewColumn.sidebar


    private var toolbarTitle: String {
        switch selectedSidebarItem {
            case "UrlToSummaryView":
                return "URL to Summary"
            case "GenerateShortStoryView":
                return "Generate a Short Story"
            case "YoutubeVideoToSummaryView":
                return "Youtube Video to Summary"
            case "GenerateIdeasView":
                return "Generate Ideas"
            default:
                return ""
        }
    }
    
    var body: some View {
        NavigationSplitView(preferredCompactColumn: $preferredColumn) {
            List(selection: $selectedSidebarItem) {
                DisclosureGroup("Tasks", isExpanded: $isExpanded) {
                    NavigationLink(value: "UrlToSummaryView") {
                        HStack {
                            Image(systemName: "link")
                            Text("URL to summary")
                        }
                    }
                    NavigationLink(value: "GenerateShortStoryView") {
                        HStack {
                            Image(systemName: "chart.bar.doc.horizontal")
                            Text("Generate a short story")
                        }
                    }
                    NavigationLink(value: "YoutubeVideoToSummaryView") {
                        HStack {
                            Image(systemName: "video")
                            Text("Youtube video to summary")
                        }
                    }
                    NavigationLink(value: "GenerateIdeasView") {
                        HStack {
                            Image(systemName: "brain.filled.head.profile")
                            Text("Generate ideas")
                        }
                    }
                }
            }
            .navigationTitle("Butler")
        } detail: {
            if let selectedSidebarItem {
                switch selectedSidebarItem {
                    case "UrlToSummaryView":
                        ToolbarWrapper(title: "URL to summary") {
                            UrlToSummaryView()
                        }
                    case "GenerateShortStoryView":
                        ToolbarWrapper(title: "Generate a Short Story") {
                            GenerateShortStoryView()
                        }
                    case "YoutubeVideoToSummaryView":
                        ToolbarWrapper(title: "Youtube Video to Summary") {
                            YoutubeVideoToSummaryView()
                        }
                    case "GenerateIdeasView":
                        ToolbarWrapper(title: "Generate Ideas") {
                            GenerateIdeasView()
                        }
                    default:
                        Text("HEY BUTLER HERE!!!")
                            .font(.largeTitle)
                            .bold()
                }
            } else {
                Text("")
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    ContentView()
}
