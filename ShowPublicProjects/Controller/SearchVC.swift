//
//  SearchVC.swift
//  ShowPublicProjects
//
//  Created by Jorge Gomez on 2018-04-02.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  var allRepos = [Repository]()
  
  override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
  }
  
  func setupViews(){
   tableView.register(RepoCell.self, forCellReuseIdentifier: Identifiers.publicReposCellId)
   tableView.estimatedRowHeight = 30
   tableView.rowHeight = UITableViewAutomaticDimension
   
  searchBar.delegate = self
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if searchBar.text != "" {
      self.dismissKeyboard()
      SVProgressHUD.show(withStatus: "Searching...")
      APIService.searchReposForKeyword(keyword: searchBar.text!) { (reposFound) in
        SVProgressHUD.dismiss()
        self.allRepos = reposFound
        self.tableView.reloadData()
      }
    }
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return allRepos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.publicReposCellId, for: indexPath) as! RepoCell
    let currentRepo = allRepos[indexPath.row]
    cell.repoTitleText = currentRepo.name
    return cell
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let currentRepo = allRepos[indexPath.row]
    APIService.getUserInformation(username: currentRepo.owner_username) { (ownerInfo) in
      let sb = UIStoryboard(name: Identifiers.mainSB, bundle: nil)
      let vc = sb.instantiateViewController(withIdentifier: Identifiers.repoDetailScreen) as! RepoDetailVC
      vc.repository = currentRepo
      vc.owner = ownerInfo
      self.present(vc, animated: true, completion: nil)
    }
  }
  
  @IBAction func backBtnTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
}
