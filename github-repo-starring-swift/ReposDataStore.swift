//
//  ReposDataStore.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()
    fileprivate init() {}
    
    var repositories:[GithubRepository] = []
    
    func getRepositoriesWithCompletion(_ completion: @escaping () -> ()) {
        GithubAPIClient.getRepositories { (reposArray) in
            self.repositories.removeAll()
            for dictionary in reposArray {
                let repoDictionary = dictionary 
                let repository = GithubRepository(dictionary: repoDictionary)
                self.repositories.append(repository)
                
            }
            completion()
        }
    }
    
    func toggleStarStatus(for repoObject: GithubRepository, completion: @escaping (Bool)-> ()) {
        
        GithubAPIClient.checkIfRepositoryIsStarred(fullName: repoObject.fullName) { isStarred in
            if isStarred == true {
                GithubAPIClient.unstarRepository(name: repoObject.fullName, completion: { (success) in
                    completion(success)
                })
                
            } else {
                GithubAPIClient.starRepository(name: repoObject.fullName, completion: { (success) in
                    completion(success)
                })
            }
        }
    }

}
