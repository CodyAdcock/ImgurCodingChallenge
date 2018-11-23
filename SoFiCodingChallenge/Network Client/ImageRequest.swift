//
//  ImageRequest.swift
//  SoFiCodingChallenge
//
//  Created by Cody on 11/23/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation
import UIKit

class ImageRequest{
    
    let baseURL = "https://api.imgur.com/3/gallery/search/time/"
    
    func searchImages(searchRequest: String, page: Int, completion: @escaping([ImgurImage]?) -> Void){
        
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = "\(page)"
        urlComponents?.queryItems = [URLQueryItem(name: "q", value: searchRequest)]
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        request.setValue("Client-­ID 126701cd8332f32", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){(data,_,error) in
            if let error = error {
                print ("Error with dataTask: \(#function) \(error) \(error.localizedDescription)")
                completion(nil); return
            }
            guard let data = data else {completion(nil);return}
            do{
                let posts = try JSONDecoder().decode(JsonDictionary.self, from: data).posts
                completion(posts)
                
            } catch let error{
                print("Error with our JSONDecoder:  \(error) \(error.localizedDescription)")
                completion([]); return
            }
        }.resume()
    }
    
    func fetchImage(imgurImage: ImgurImage, completion: @escaping(UIImage?) -> Void){
        guard let link = URL(string: imgurImage.link) else {completion(nil); return}
        URLSession.shared.dataTask(with: link){(data,_,error) in
            do {
                if let error = error { throw error}
                guard let data = data else { throw NSError() }
                let image = UIImage(data: data)
                completion(image)
                
            }catch let error {
                print("Error fetcing image \(error) \(error.localizedDescription)")
                completion(nil); return
            }
        }.resume()
    }
}
