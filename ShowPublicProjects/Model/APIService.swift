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
let REPO_OWNER = "/users/"
let SEARCH = "/search/repositories"

class APIService {

  //Get all public repositories. Only returns about 300 repos.
  static func getPublicRepositories(completed: @escaping ([Repository]) -> ()){
    var allRepositoriesArray = [Repository]()
    
    guard let token = userDefaults.object(forKey: Identifiers.accessToken) as? String else { return }
    
    let headers: HTTPHeaders = [
      "Authorization": token,
      "Accept": "application/vnd.github.v3+json"
    ]
    
    guard Reachability.isConnectedToNetwork() else {
      // show internet error message
      return
    }
   
    let url = URL(string: "\(BASE_URL)\(PUBLIC_REPOS)")
    Alamofire.request(url!, method: .get, parameters: nil, headers: headers).responseJSON(completionHandler: { (response) in
        debugPrint(response)
        let statusCode = response.response?.statusCode
        if statusCode == 200 {
          guard let reposData = response.value as? [Dictionary<String,Any>] else {
            return
          }
          
          for repo in reposData {
            //Owner name
            guard let ownerData = repo["owner"] as? Dictionary<String,Any> else { continue }
            let name = ownerData["login"] as? String ?? "No Name"

            //Repo info
            let repo_id = repo["id"] as? Int ?? -1
            let description = repo["description"] as? String ?? ""
            let repo_name = repo["name"] as? String ?? "No name"
            let repoURL = repo["repo_url"] as? String ?? ""
            
            let newRepo = Repository(id: repo_id, description: description, name: repo_name, repoURL: repoURL, owner_username: name)
            allRepositoriesArray.append(newRepo)
          }
        }
      completed(allRepositoriesArray)
    })
  }
  
  //Returns all public repos. Returns repos starting by the repo-id provided.
  static func getPublicRepositoriesSince(repoId: String, completed: @escaping ([Repository]) -> ()){
    var allRepositoriesArray = [Repository]()
    
    guard let token = userDefaults.object(forKey: Identifiers.accessToken) as? String else { return }
    
    let parameters = [
      "since" : repoId
    ]
    
    let headers: HTTPHeaders = [
      "Authorization": token,
      "Accept": "application/vnd.github.v3+json"
    ]
    
    guard Reachability.isConnectedToNetwork() else {
      // show internet error message
      return
    }
   
    let url = URL(string: "\(BASE_URL)\(PUBLIC_REPOS)")
    Alamofire.request(url!, method: .get, parameters: parameters, headers: headers).responseJSON(completionHandler: { (response) in
        debugPrint(response)
        let statusCode = response.response?.statusCode
        if statusCode == 200 {
          guard let reposData = response.value as? [Dictionary<String,Any>] else {
            return
          }
          
          for repo in reposData {
            //Owner name
            guard let ownerData = repo["owner"] as? Dictionary<String,Any> else { continue }
            let name = ownerData["login"] as? String ?? "No Name"

            //Repo info
            let repo_id = repo["id"] as? Int ?? -1
            let description = repo["description"] as? String ?? ""
            let repo_name = repo["name"] as? String ?? "No name"
            let repoURL = repo["repo_url"] as? String ?? ""

            
            let newRepo = Repository(id: repo_id, description: description, name: repo_name, repoURL: repoURL, owner_username: name)
            allRepositoriesArray.append(newRepo)
          }
        }
      completed(allRepositoriesArray)
    })
  }
  
  //get detailed data about user/ repo owner
  static func getUserInformation(username: String, completed: @escaping (Owner) -> ()){
    
    guard let token = userDefaults.object(forKey: Identifiers.accessToken) as? String else {
      //show error message and go back to login page
      return
    }
    
    let headers: HTTPHeaders = [
      "Authorization": token,
      "Accept": "application/vnd.github.v3+json"
    ]
    
    guard Reachability.isConnectedToNetwork() else {
      //show internet error message
      return
    }
    
    let url = URL(string: "\(BASE_URL)\(REPO_OWNER)\(username)")
    Alamofire.request(url!, method: .get, parameters: nil, headers: headers).responseJSON(completionHandler: { (response) in
        debugPrint(response)
        let statusCode = response.response?.statusCode
        var owner = Owner()
        if statusCode == 200 {
          guard let ownerData = response.value as? Dictionary<String,Any> else {
            completed(owner)
            return
          }
          
          let id = ownerData["id"] as? Int ?? -1
          let totalFollowers = ownerData["followers"] as? Int ?? 0
          let totalFollowing = ownerData["following"] as? Int ?? 0
          let name = ownerData["name"] as? String ?? ""
          let company = ownerData["company"] as? String ?? ""
          let email = ownerData["email"] as? String ?? ""
          let publicRepoNumber = ownerData["public_repos"] as? Int ?? 0
          let avatarURL = ownerData["avatar_url"] as? String ?? ""
          
         owner = Owner(avatar_url: avatarURL, id: id, name: name, followers_number: totalFollowers, following_number: totalFollowing, company: company, email: email, public_repos_number: publicRepoNumber)
          
        }
      completed(owner)
    })
  }
  
  static func searchReposForKeyword(keyword: String, completed: @escaping ([Repository]) -> ()){
    var allRepositoriesArray = [Repository]()
    
    guard let token = userDefaults.object(forKey: Identifiers.accessToken) as? String else { return }
    
    let parameters = [
      "q" : keyword
    ]
    
    let headers: HTTPHeaders = [
      "Authorization": token,
      "Accept": "application/vnd.github.v3+json"
    ]
    
    guard Reachability.isConnectedToNetwork() else {
      // show internet error message
      return
    }
   
    let url = URL(string: "\(BASE_URL)\(SEARCH)")
    Alamofire.request(url!, method: .get, parameters: parameters, headers: headers).responseJSON(completionHandler: { (response) in
        debugPrint(response)
        let statusCode = response.response?.statusCode
        if statusCode == 200 {
          guard let searchData = response.value as? Dictionary<String,Any> else {
            return
          }
          
          let reposFound = searchData["items"] as? [Dictionary<String,Any>] ?? [Dictionary<String,Any>]()
          

          for repo in reposFound {
            //Owner name
            guard let ownerData = repo["owner"] as? Dictionary<String,Any> else { continue }
            let name = ownerData["login"] as? String ?? "No Name"

            //Repo info
            let repo_id = repo["id"] as? Int ?? -1
            let description = repo["description"] as? String ?? ""
            let repo_name = repo["name"] as? String ?? "No name"
            let repoURL = repo["repo_url"] as? String ?? ""

            
            let newRepo = Repository(id: repo_id, description: description, name: repo_name, repoURL: repoURL, owner_username: name)
            allRepositoriesArray.append(newRepo)
          }
        }
      completed(allRepositoriesArray)
    })
  }
  
  
  
  
  
}
