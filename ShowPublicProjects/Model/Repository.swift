//
//  GITProject.swift
//  ShowPublicProjects
//
//  Created by Jorge Gomez on 2018-03-26.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import Foundation

class Repository {
  
  private var _id: Int
  private var _description: String
  private var _name: String
  private var _repoURL: String
  private var _owner_username: String
  
  var id: Int {
    return _id
  }
  
  var owner_username: String {
    return _owner_username
  }
  
  var description: String {
    return _description
  }
  
  var name: String {
    return _name
  }
  
  var repoURL: String {
    return _repoURL
  }
  
  init(id: Int, description: String, name: String, repoURL: String, owner_username: String){
    self._id = id
    self._description = description
    self._name = name
    self._repoURL = repoURL
    self._owner_username = owner_username
  }
  
  init(){
    self._id = -1
    self._name = ""
    self._description = ""
    self._repoURL = ""
    self._owner_username = ""
  }
  
  
}
