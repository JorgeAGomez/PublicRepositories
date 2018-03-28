//
//  APIService.swift
//  ShowPublicProjects
//
//  Created by Jorge Gomez on 2018-03-26.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import Foundation
import Alamofire
import Auth0
/*  THING TO KEEP IN MIND ABOUT Git API:
 
    - Blank fields are included as null instead of being omitted
    - All timestamps return in ISO 8601 format:
*/


let BASE_URL = "https://api.github.com"

let PUBLIC_REPOS = "/repositories"

//personal token
let AUTH_TOKEN = "ec2b05a88ef2f5154b625161535dde6bea085e6a"

class APIService {

  static func getPublicRepositories(completed: @escaping ([Repository]) -> ()){
    var allRepositoriesArray = [Repository]()
    
    guard let token = userDefaults.object(forKey: Identifiers.accessToken) as? String else { return }
    
    let headers: HTTPHeaders = [
      "Authorization": token,
      "Accept": "application/vnd.github.v3+json"
    ]
    
    if Reachability.isConnectedToNetwork() {
      
      let url = URL(string: "\(BASE_URL)\(PUBLIC_REPOS)")
      Alamofire.request(url!, method: .get, parameters: nil, headers: headers).responseJSON(completionHandler: { (response) in
          debugPrint(response)
          let statusCode = response.response?.statusCode
          if statusCode == 200 {
            guard let reposData = response.value as? [Dictionary<String,Any>] else {
              return
            }
            
            for repo in reposData {
              //Owner info
              guard let ownerData = repo["owner"] as? Dictionary<String,Any> else { continue }
              let avatarUrl = ownerData["avatar_url"] as? String ?? ""
              let owner_id = ownerData["id"] as? Int ?? -1
              let name = ownerData["name"] as? String ?? ""
              let followersUrl = ownerData["followers_url"] as? String ?? ""
              let followingUrl = ownerData["following_url"] as? String ?? ""
              let htmlUrl = ownerData["html_url"] as? String ?? ""
              
              let repoOwner = Owner(avatarUrl: avatarUrl, id: owner_id, name: name, followersUrl: followersUrl, followingUrl: followingUrl, htmlUrl: htmlUrl)
              
              //Repo info
              let repo_id = repo["id"] as? Int ?? -1
              let description = repo["description"] as? String ?? ""
              let repo_name = repo["name"] as? String ?? "No name"
              let repoURL = repo["repo_url"] as? String ?? ""
              guard let isPrivate = repo["private"] as? Bool else {
                continue
              }
              
              let newRepo = Repository(id: repo_id, owner: repoOwner, description: description, name: repo_name, repoURL: repoURL)
              allRepositoriesArray.append(newRepo)
            }
          }
        completed(allRepositoriesArray)
      })
      
      
    }
    
    
    
  }
  
  
  
}
