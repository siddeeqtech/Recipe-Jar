//
//  RecipeService.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//
//Purpose:To interact with the API
import Foundation


protocol RecipeService {
    func fetch() async throws -> String
}

final class RecipeServiceImpl: RecipeService {
    func fetch() async throws -> String {
        let urlSession = URLSession.shared
        let url = URL(string: "")
        let (data,_) = try await urlSession.data(from: url!)
        
        
        
        return try JSONDecoder().decode(String.self, from: data)
    }
}
