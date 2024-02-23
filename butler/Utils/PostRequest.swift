//
//  PostRequest.swift
//  butler
//
//  Created by Manoj on 23/02/24.
//

import Foundation

extension Utility {
    static func PostButlerRequest(endPoint: String, seed: String) async throws -> String {
        guard let baseURL = URL(string: Utility.Constants.baseURL) else { throw URLError(.badURL) }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = endPoint

        guard let url = urlComponents?.url else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = ["seed": seed]
        print(json)
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else { throw URLError(.badURL) }
        print(jsonData, url)

        request.httpBody = jsonData

        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let responseData = try decoder.decode(ResponseData.self, from: data)
        return responseData.response
    }
}
