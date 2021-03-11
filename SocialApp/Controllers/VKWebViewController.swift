//
//  VKWebViewController.swift
//  SocialApp
//
//  Created by Иван Казанцев on 26.02.2021.
//

import UIKit
import WebKit

class VKWebViewController: UIViewController {

    @IBOutlet weak var authWebView: WKWebView! {
        didSet{
            authWebView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = NetworkManager.shared.networking()
        authWebView.load(request)

    }

}

extension VKWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
        let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
                    .components(separatedBy: "&")
                    .map { $0.components(separatedBy: "=")}
                    .reduce([String: String]()) { result, param in
                        var dict = result
                        let key = param[0]
                        let value = param[1]
                        dict[key] = value
                        return dict
                    }
        AppSession.instance.token = params["access_token"]
        AppSession.instance.userId = params["user_id"]
        print("Token: \(AppSession.instance.token ?? "Failed")")
        print("User ID: \(AppSession.instance.userId ?? "Failed")")
        
        decisionHandler(.cancel)
        
        if AppSession.instance.token != nil {
        performSegue(withIdentifier: "toTabBarController", sender: AnyObject.self)
        } else {
            return
        }
    }
    
}
