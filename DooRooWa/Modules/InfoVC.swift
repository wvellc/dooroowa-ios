//
//  InfoVC.swift
//  DooRooWa
//
//  Created by Wve iOS Developer on 3/22/23.
//

import UIKit
import WebKit

class InfoVC: UIViewController {
    
    static func instance() -> InfoVC {
        return InfoVC.instatiateFromStoryBoard(appStoryboard: AppStoryboard.common)
    }
    
    //MARK: - IBOutlet Declaratio
    
    @IBOutlet weak var viewWebKit: UIView!
    
    //MARK: - Variable Declaration
    
    private var webViewInfo : WKWebView!
    var objStrURL = "https://wvelabs.com/solutions/"
    var objTitle = "terms_and_conditions".localized
    
    //MARK: - Override Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.doInitialSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        print("Info screen released from memory")
    }
    
    //MARK: - IBAction Methods
    
    //MARK: - Custom Class Methods
    
    fileprivate func doInitialSettings(){
        self.title = objTitle
        webViewInfo = WKWebView(frame: self.view.frame)
        webViewInfo.navigationDelegate = self
        webViewInfo.backgroundColor = .clear
        webViewInfo.scrollView.backgroundColor = .clear
        viewWebKit.layoutIfNeeded()
        
        if let aUrl = URL(string: objStrURL) {
            let aRrequest = URLRequest(url: aUrl)
            webViewInfo.load(aRrequest)
            viewWebKit.addSubview(webViewInfo)
        }
    }
}
//MARK: - WKNavigationDelegate  Methods
extension InfoVC : WKNavigationDelegate {
    //MARK: - WKNavigationDelegate
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("finish to load")
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
