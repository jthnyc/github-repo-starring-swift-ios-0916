//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    class func getRepositories(with completion: @escaping ([[String:AnyObject]]) -> Void){
        
        let urlString = "\(Secrets.githubAPIURL)/repositories?client_id=\(Secrets.clientID)&client_secret=\(Secrets.clientSecret)"
        
        let url = URL(string: urlString)
    
        
        if let unwrappedUrl = url {
            let session = URLSession.shared

            let task = session.dataTask(with: unwrappedUrl) { (data, response, error) in
                if let unwrappedData = data {
                    
                    do {
                        let responseJSONArray = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String:Any]]
                        completion(responseJSONArray as [[String : AnyObject]])
                        
                    }catch{
                        print("error")
                    }
                }
            }
            
            task.resume()
        }
    }

        
    class func checkIfRepositoryIsStarred(fullName: String , completion: @escaping (Bool) -> Void) {
        
        var isStarred = false
        let urlString = "\(Secrets.githubAPIURL)/user/starred/\(fullName)?access_token=\(Secrets.personalToken)"
        let url = URL(string: urlString)
        
        guard let unwrappedUrl = url else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: unwrappedUrl) { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            
            if httpResponse.statusCode == 204 {
                isStarred = true
            } else if httpResponse.statusCode == 404 {
                isStarred = false
            }
            completion(isStarred)
        }
        
        task.resume()
       
    }
    
    
    class func starRepository(name: String, completion: (Bool) -> ()) {
        
        
        let urlString = "\(Secrets.githubAPIURL)/user/starred/\(name)?access_token=\(Secrets.personalToken)"
        let url = URL(string: urlString)
        
        guard let unwrappedURL = url else { return }
        
        var request = URLRequest(url: unwrappedURL)
        request.httpMethod = "PUT"
        request.addValue("0", forHTTPHeaderField: "Content-Length")
        
       
    
        
    }
    
   class func unstarRepository(name: String, completion: (Bool) -> ()){
        
    
        let urlString = "\(Secrets.githubAPIURL)/user/starred/\(name)?access_token=\(Secrets.personalToken)"
        let url = URL(string: urlString)
        
        guard let unwrappedURL = url else { return }
        
        var request = URLRequest(url: unwrappedURL)
        request.httpMethod = "DELETE"
        request.addValue("0", forHTTPHeaderField: "Content-Length")
        
    
        

    }



}

