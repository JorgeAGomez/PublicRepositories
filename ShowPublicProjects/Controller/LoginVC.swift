//
//  LoginVC.swift
//  ShowPublicProjects
//
//  Created by Jorge Gomez on 2018-03-26.
//  Copyright © 2018 codeByMe. All rights reserved.
//

import UIKit
import SVProgressHUD
import Auth0

class LoginVC: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var enterTokenBtn: UIButton!
  @IBOutlet weak var descriptionLbl: UILabel!
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    checkForToken()
  }

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }
  
  private func checkForToken(){
    //checks if an access token is available otherwise login with credentials to get one.
    if let _ = userDefaults.object(forKey: Identifiers.accessToken) as? String {
      enterTokenBtn.setTitle("Go to repositories!", for: .normal)
      descriptionLbl.text = "Access token is available. You can go check public repositories now."
    } else {
      enterTokenBtn.setTitle("Login", for: .normal)
      descriptionLbl.text = "Access token is not available. Please login to get a new access token."
    }
  }
  
  @IBAction func enterTokenBtnTapped(_ sender: Any) {
    //checks if an access token is available otherwise login with credentials to get one.
    if let _ = userDefaults.object(forKey: Identifiers.accessToken) as? String {
      SVProgressHUD.show(withStatus: "Loading repos...")
      APIService.getPublicRepositories { (repos) in
        SVProgressHUD.dismiss()
        let sb = UIStoryboard(name: Identifiers.mainSB, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: Identifiers.publicProjects) as! PublicProjectsVC
        vc.allRepos = repos
        let nvc = UINavigationController(rootViewController: vc)
        nvc.isNavigationBarHidden = true
        self.present(nvc, animated: true, completion: nil)
      }
    } else {
        guard let clientInfo = plistValues(bundle: Bundle.main) else { return }
        Auth0
          .webAuth()
          .scope("openid profile")
          .audience("https://" + clientInfo.domain + "/userinfo")
          .start {
              SVProgressHUD.show(withStatus: "Loading repos...")
              switch $0 {
              case .failure(let error):
                SVProgressHUD.dismiss()
                let errorString = error as? String ?? "Authentication failed"
                self.showErrorAlert(errorString)
              case .success(let credentials):
                  SVProgressHUD.dismiss()
                  guard let accessToken = credentials.accessToken else { return }
                  //SAVE TOKEN
                  userDefaults.set(accessToken, forKey: Identifiers.accessToken)
                  APIService.getPublicRepositories { (repos) in
                    SVProgressHUD.dismiss()
                    let sb = UIStoryboard(name: Identifiers.mainSB, bundle: nil)
                    let vc = sb.instantiateViewController(withIdentifier: Identifiers.publicProjects) as! PublicProjectsVC
                    vc.allRepos = repos
                    let nvc = UINavigationController(rootViewController: vc)
                    nvc.isNavigationBarHidden = true
                    self.present(nvc, animated: true, completion: nil)
                  }
              }
          }
    }
  }

  fileprivate func showErrorAlert(_ message: String) {
    let alert = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }

  func plistValues(bundle: Bundle) -> (clientId: String, domain: String)? {
      guard
          let path = bundle.path(forResource: "Auth0", ofType: "plist"),
          let values = NSDictionary(contentsOfFile: path) as? [String: Any]
          else {
              return nil
      }

      guard
          let clientId = values["ClientId"] as? String,
          let domain = values["Domain"] as? String
          else {
              return nil
      }
      return (clientId: clientId, domain: domain)
  }
  

}
