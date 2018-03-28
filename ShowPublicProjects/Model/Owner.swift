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
  private var _followers_url: String
  private var _following_url: String
  private var _html_url: String
  
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
  
  var followers_url: String {
    return _followers_url
  }
  
  var following_url: String {
    return _following_url
  }
  
  var html_url: String {
    return _html_url
  }
  
  
  init(avatarUrl: String, id: Int, name: String, followersUrl: String, followingUrl: String, htmlUrl: String){
    self._avatar_url = avatarUrl
    self._id = id
    self._name = name
    self._following_url = followingUrl
    self._followers_url = followersUrl
    self._html_url = htmlUrl
  }
  
  init(){
    self._avatar_url = ""
    self._id = -1
    self._name = ""
    self._followers_url = ""
    self._following_url = ""
    self._html_url = ""
  }
  
  
  
  
}
