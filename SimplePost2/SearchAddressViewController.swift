//
//  SearchAddressViewController.swift
//  simplePost
//
//  Created by byongguen son on 2017. 7. 26..
//  Copyright © 2017년 byongguen son. All rights reserved.
//

import UIKit
import WebKit
class SearchAddressViewController: UIViewController,WKScriptMessageHandler{
    var webView : WKWebView!
    @IBOutlet weak var navBar: MainNavigationView!
    var postalCode: String?
    var address: String?
    var ReturnController : SPAddress!
    func initNavigationView() {
        self.navBar.setTitle(title: "우편번호 검색")
        self.navBar.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 17.0)
        self.navBar.setTitleColor(color: .white)
        self.navBar.setBGColor(color: UIColor(red: 33/255, green: 150/255, blue: 243/255, alpha: 1))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationView()
        self.navBar.leftButton.setImage(UIImage(named: "back"), for: .normal)
        self.navBar.leftButton.isHidden = false
        self.navBar.leftButton.addTarget(self, action: #selector(handleBack), for: .touchUpInside)
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        self.webView = WKWebView(frame: .zero, configuration: config)
        
        view.addSubview(webView)
        
        prepareWebView()
    }
    @objc
    func handleBack(){
        self.navigationController?.popViewController(animated: true)
    }
    func prepareWebView(){
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: navBar.bottomAnchor).isActive = true
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        let url = URL(string: "http://localhost/map.html")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if let postalCodeData = message.body as? [String: Any] {
            postalCode = postalCodeData["zonecode"] as? String ?? ""
            address = postalCodeData["addr"] as? String ?? ""
            
        }
        ReturnController?.postalField = postalCode!
        ReturnController?.addrField = address!
        self.navigationController?.popViewController(animated: true)
    }
}
