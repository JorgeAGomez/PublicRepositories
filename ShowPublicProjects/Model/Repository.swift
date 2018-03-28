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
  private var _owner: Owner
  private var _description: String
  private var _name: String
  private var _repoURL: String
  
  var id: Int {
    return _id
  }
  
  var owner: Owner {
    return _owner
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
  
  init(id: Int, owner: Owner, description: String, name: String, repoURL: String){
    self._id = id
    self._owner = owner
    self._description = description
    self._name = name
    self._repoURL = repoURL
  }
  
  init(){
    self._id = -1
    self._owner = Owner()
    self._name = ""
    self._description = ""
    self._repoURL = ""
  }
  
  
}
