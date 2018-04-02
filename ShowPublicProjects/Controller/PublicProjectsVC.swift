//
//  PublicProjectsVC.swift
//  ShowPublicProjects
//
//  Created by Jorge Gomez on 2018-03-28.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import UIKit
import SVProgressHUD

class PublicProjectsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

  var allRepos = [Repository]()

  @IBOutlet weak var messageLbl: UILabel!
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  var searchMode = false
  
  override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
      hideKeyboardWhenTappedAround()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  private func showMessageLbl(){
    messageLbl.alpha = 1
    tableView.separatorStyle = .none
  }
  
  private func hideMessageLbl(){
    messageLbl.alpha = 0
    tableView.separatorStyle = .singleLine
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
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty {
      searchMode = false
      dismissKeyboard()
      APIService.getPublicRepositories { (repos) in
        SVProgressHUD.dismiss()
        self.allRepos = repos
        self.tableView.reloadData()
      }
    } else {
      searchMode = true
    }
  }
  
  
  //  MARK: - DATA SOURCE
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if allRepos.count < 1 {
      showMessageLbl()
    } else {
      hideMessageLbl()
    }
    
    return allRepos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.publicReposCellId, for: indexPath) as? RepoCell else { return UITableViewCell() }
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
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
    // Check scrolled percentage
    let yOffset = tableView.contentOffset.y;
    let height = tableView.contentSize.height - tableView.frame.size.height;
    let scrolledPercentage = yOffset / height;
    
    // Check if all the conditions are met to allow loading the next page
    if (scrolledPercentage > 0.6) && !searchMode {
    // This is the bottom of the table view, load more data here.
    SVProgressHUD.show()
      let idString = "\(allRepos[indexPath.row].id)"
      APIService.getPublicRepositoriesSince(repoId: idString, completed: { (newRepos) in
        SVProgressHUD.dismiss()
        self.allRepos += newRepos
        tableView.reloadData()
      })
    }
  }

  @IBAction func logoutBtnTapped(_ sender: Any) {
    userDefaults.set(nil, forKey: Identifiers.accessToken)
    self.dismiss(animated: true, completion: nil)
  }
  
}
