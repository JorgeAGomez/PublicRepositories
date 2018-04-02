//
//  RepoDetailVC.swift
//  ShowPublicProjects
//
//  Created by Jorge Gomez on 2018-03-28.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import UIKit

class RepoDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var publicReposLbl: UILabel!
  @IBOutlet weak var followingLbl: UILabel!
  @IBOutlet weak var followersLbl: UILabel!
  @IBOutlet weak var emailLbl: UILabel!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var ownerLbl: UILabel!
  @IBOutlet weak var repoNameLbl: UILabel!
  @IBOutlet weak var repoAvatarImg: UIImageView!
  var repository: Repository!
  var owner: Owner!
  
  var repoData = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    let repodescription = repository.description
    repoData.append(repodescription)
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  private func setupViews(){
    ownerLbl.text = owner.name
    followersLbl.text = "Followers: \(owner.followers_number)"
    followingLbl.text = "Following: \(owner.following_number)"
    publicReposLbl.text = "Public repositories: \(owner.public_repo_number)"
    emailLbl.text = "\(owner.email)"
    repoNameLbl.text = repository.name
    repoAvatarImg.downloadedFrom(link: owner.avatar_url, contentMode: .scaleAspectFit)
    repoAvatarImg.layer.cornerRadius = 10
    
    //
    tableView.estimatedRowHeight = 50
    tableView.rowHeight = UITableViewAutomaticDimension
    
    //register cells
    tableView.register(detailCell.self, forCellReuseIdentifier: Identifiers.detailCellId)
  }

  @IBAction func backBtnTapped(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repoData.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.detailCellId, for: indexPath) as? detailCell else { return UITableViewCell() }
    let currentText = repoData[indexPath.row]
    cell.cellText = currentText
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }
}
