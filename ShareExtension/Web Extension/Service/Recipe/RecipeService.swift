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
    
   // func scrapeRecipe()
    
   func postRequest(recipeURL: String, completion: @escaping (Recipe?, Error?) -> Void)
    func fetchRecipe(recipeURL: String) async throws -> Recipe
}


    //defer

final class RecipeServiceImpl: RecipeService {
    
    enum RecipeServiceError: Error {
        case faild
        case wrongURL
        case faildToDecode
        case invalidStatusCode
    }
    
    //defer is loading?
    func fetch() async throws -> Welcome1 {
        let urlSession = URLSession.shared
        
        guard let url = URL(string: "http://whiskapps.com//sendAndGetMyName/yazoon/") else {
            throw RecipeServiceError.wrongURL
        }
            
            let (data,response) = try await urlSession.data(from: url)
             
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                throw RecipeServiceError.invalidStatusCode
            }
            let decodedData = try JSONDecoder().decode(Welcome1.self, from: data)
            return decodedData
    }
    
    
    
    //MARK: get recipe details post api call **NOT NEEDED**
     func postRequest(recipeURL: String, completion: @escaping (Recipe?, Error?) -> Void) {

        //declare parameter as a dictionary which contains string as key and value combination.
        let parameters = ["websiteUrl": recipeURL]

        //create the url with NSURL
        let url = URL(string: "http://www.whiskapps.com/whiskApp/webExtension/getRecipeInformation/")!

        //create the session object
        let session = URLSession.shared

        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            completion(nil, error)
        }

        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
    
                
                
                guard error == nil else {
                    completion(nil, error)
                    return
                }
                
                guard let data = data else {
                    completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                    return
                }
                
                do {
                    //create json object from data
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else {
                        completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                        return
                    }
                    DispatchQueue.main.async {
                        if let decodedRecipe = try? JSONDecoder().decode(Recipe.self, from: data) {
                            
                            print("________________________________________________________________________________________________")
                            //print(decodedRecipe)
                            completion(decodedRecipe, nil)
                            
                            print("________________________________________________________________________________________________")
                            
                            
                        }
                    }
                    
                    
                    
                    
                    
                    //print(json)
                    //completion(json, nil)
                } catch let error {
                    print("ee\(error.localizedDescription)")
                    
                    completion(nil, error)
                }
                
       
        })

        task.resume()
    }
    
    
    
    func fetchRecipe(recipeURL: String) async throws -> Recipe {
       
        //declare parameter as a dictionary which contains string as key and value combination.
        let parameters = ["websiteUrl": recipeURL,"userID": "9839d06e-7617-4476-9adc-90e5e880a642"]

        //create the url with NSURL
        let url = URL(string: "http://www.whiskapps.com/whiskApp/webExtension/getRecipeInformation/")!

        //create the session object
        let session = URLSession.shared

        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            
            //completion(nil, error)
        }

        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        //let (data,response) = try await URLSession.shared.data(for: request)
        
        let (data,response) = try await  URLSession.shared.data(for: request)
        
       //check if response status is acceptaple between 200 and 300
        guard let response = response as? HTTPURLResponse,(200..<300) ~= response.statusCode  else {
           print(response.description)
           throw RecipeServiceError.invalidStatusCode
       }
       let decodedData = try JSONDecoder().decode(Recipe.self, from: data)
       return decodedData
        
        
      
        
    }
    
    
    
    
    
    
    
    

    
}
