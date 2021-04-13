//
//  ViewController.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 22/11/20.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import Firebase

class LoginViewController: UIViewController, LoginButtonDelegate,GIDSignInDelegate {
    
    @IBOutlet weak var loginUiTextField: UITextField!
    
    @IBOutlet weak var passwordUiTextField: UITextField!
    
    @IBOutlet weak var loginUiButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet var loginView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.topItem?.searchController = nil
        if(FirebaseMarvelComicService.isLogged()){
            redirectToHomePage()
        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        loginUiTextField.overrideUserInterfaceStyle = .light
        passwordUiTextField.overrideUserInterfaceStyle = .light
        
        self.loginUiButton.layer.cornerRadius = 4.0;
        self.signUpButton.layer.cornerRadius = 4.0;
        
        buildFacebookButton()
        buildGoogleButton()
        if ApplicationService.isDarkMode(){
            loginView.backgroundColor = UIColor.systemBackground
            loginUiButton.backgroundColor = UIColor.white
            loginUiButton.setTitleColor(UIColor.black, for: .normal)
            
            signUpButton.backgroundColor = UIColor.white
            signUpButton.setTitleColor(UIColor.black, for: .normal)
        }
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        redirectToHomePage()
    }
    
    @objc func redirectToHomePage(){
        if let tabBar = UIStoryboard(name: "TabBar", bundle: nil).instantiateInitialViewController() as? TabBarViewController {
            self.navigationController?.pushViewController(tabBar, animated: true)
        }
    }
    
    func buildFacebookButton(){
        
        let facebookLoginButton = FBLoginButton()
        facebookLoginButton.delegate = self
        facebookLoginButton.permissions = ["public_profile", "email"]
        
        facebookLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(facebookLoginButton)
        
        let constrains:[NSLayoutConstraint] = [
            NSLayoutConstraint(item: facebookLoginButton, attribute: .top, relatedBy: .equal, toItem: signUpButton, attribute: .bottom, multiplier: 1.0, constant: 40),
            
            NSLayoutConstraint(item: facebookLoginButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -20),
            
            NSLayoutConstraint(item: facebookLoginButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 20),
            
            
        ]
        
        view.addConstraints(constrains)
        
    }
    
    func buildGoogleButton(){
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        //GIDSignIn.sharedInstance().signIn()
        
        let googleLoginButton = GIDSignInButton()
        if ApplicationService.isDarkMode(){
            googleLoginButton.colorScheme = GIDSignInButtonColorScheme.dark
        }
        googleLoginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(googleLoginButton)
        
        let constrains:[NSLayoutConstraint] = [
            NSLayoutConstraint(item: googleLoginButton, attribute: .top, relatedBy: .equal, toItem: signUpButton, attribute: .bottom, multiplier: 1.0, constant: 80),
            
            NSLayoutConstraint(item: googleLoginButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -15),
            
            NSLayoutConstraint(item: googleLoginButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 15),
            
        ]
        view.addConstraints(constrains)
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
      if let error = error {
        print(error.localizedDescription)
        return
      }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        // Authenticate with Firebase using the credential object
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Error occurs when authenticate with Firebase: \(error.localizedDescription)")
                }
                   
                self.redirectToHomePage()
            }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Deslogando Facebook")
        LoginManager().logOut()
        if let comicDetail = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(comicDetail, animated: true)
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        print(error)
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        // Authenticate with Firebase using the credential object
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Error occurs when authenticate with Firebase: \(error.localizedDescription)")
                }
                    
                self.redirectToHomePage()
            }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Deslogando Google")
        if let comicDetail = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? LoginViewController {
            navigationController?.pushViewController(comicDetail, animated: true)
        }
    }
}

