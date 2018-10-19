//
//  NetworkService.swift
//  ASE Timer
//
//  Created by Rahul on 7/23/18.
//  Copyright © 2018 Rahul Sharma. All rights reserved.
//

import UIKit

var databaseURL: URL? {
    let url = URL(string: "https://asetimer.firebaseio.com/.json")
    return url
}

class NetworkService {
    
    static var shared = NetworkService()
    
    func getLocalEventInfo(_ completion: @escaping (ASE) -> Void) {
        
    }
    
    func downloadEventInfo(_ completion: @escaping (ASE) -> Void) {
        
        guard let databaseURL = databaseURL else {
            print("Error: Database URL invalid.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: databaseURL) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("Error: Server didn't returned any data.")
                return
            }
            
            do {
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                    print("Error: Data not convertable to JSON.")
                    return
                }
                
                let event = ASE(json: json)
                
                DispatchQueue.main.async {
                    completion(event)
                }
                
            } catch{
                print("Error: Error trying to convert data to JSON.")
                return
            }
            
        }
        
        task.resume()
        
    }
    
    
}
