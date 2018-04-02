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

  @IBOutlet weak var tableView: UITableView!
  
  
  override func viewDidLoad() {
      super.viewDidLoad()
      setupViews()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  func setupViews(){
   tableView.register(RepoCell.self, forCellReuseIdentifier: Identifiers.publicReposCellId)
   tableView.estimatedRowHeight = 30
   tableView.rowHeight = UITableViewAutomaticDimension
  }

  
  //  MARK: - DATA SOURCE
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
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
    if (scrolledPercentage > 0.6){
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
