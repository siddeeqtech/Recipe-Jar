//
//  RecipeService.swift
//  SwiftUI with Share extension 2
//
//  Created by othman shahrouri on 2/2/23.
//
//Purpose:To interact with the API
import Foundation


protocol RecipeService {
    func fetch() async throws -> Welcome1
}

final class RecipeServiceImpl: RecipeService {
 
    func fetch() async throws -> Welcome1 {
        let urlSession = URLSession.shared
        let url = URL(string: "https://25da-176-29-143-151.eu.ngrok.io/sendAndGetMyName/yazoon/")
        let (data,_) = try await urlSession.data(from: url!)
        
        
        
        return try JSONDecoder().decode(Welcome1.self, from: data)
    }
}
