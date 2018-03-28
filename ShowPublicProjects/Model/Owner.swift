//
//  Owner.swift
//  ShowPublicProjects
//
//  Created by Jorge Gomez on 2018-03-28.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import Foundation

class Owner {
  
  private var _avatar_url: String
  private var _id: Int
  private var _name: String
  private var _followers_number: Int
  private var _following_number: Int
  private var _company: String
  private var _email: String
  private var _public_repos_number: Int
  
  //create getters
  
  var avatar_url : String {
    return _avatar_url
  }
  
  var id: Int {
    return _id
  }
  
  var name: String {
    return _name
  }
  
  var followers_number: Int {
    return _followers_number
  }
  
  var following_number: Int {
    return _following_number
  }
  
  var company: String {
    return _company
  }
  
  var email: String {
    return _email
  }
  
  var public_repo_number: Int {
    return _public_repos_number
  }
  
  init(){
    self._avatar_url = ""
    self._id = -1
    self._name = ""
    self._followers_number = 0
    self._following_number = 0
    self._company = ""
    self._email = ""
    self._public_repos_number = 0
  }
  
  init(avatar_url: String, id: Int, name: String, followers_number: Int, following_number: Int, company: String, email: String, public_repos_number: Int){
    self._avatar_url = avatar_url
    self._id = id
    self._name = name
    self._followers_number = followers_number
    self._following_number = following_number
    self._company = company
    self._email = email
    self._public_repos_number = public_repos_number
  }
  
  
  
}
