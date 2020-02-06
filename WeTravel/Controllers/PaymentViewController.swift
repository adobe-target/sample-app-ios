//
//  PaymentViewController.swift
//
//  Copyright 1996-2019. Adobe Inc. All Rights Reserved
//  WeTravel
//

import UIKit
import WebKit
class PaymentViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    //@IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        do {
            guard let filePath = Bundle.main.path(forResource: "adobe/index", ofType: "html")
                else {
                    // File Error
                    print ("File reading error")
                    return
            }
            let contentController = WKUserContentController();
            contentController.add(
                self,
                name: "callbackHandler"
            )
            
            let config = WKWebViewConfiguration()
            config.userContentController = contentController
          let  webView = WKWebView(frame: CGRect.zero, configuration: config)
            webView.navigationDelegate = self
            self.view = webView

            let contents =  try String(contentsOfFile: filePath, encoding: .utf8)
            let baseUrl = URL(fileURLWithPath: filePath)
            webView.loadHTMLString(contents as String, baseURL: baseUrl)
            webView.navigationDelegate = self
            webView.uiDelegate = self
        }
        catch {
            print ("File HTML error")
        }
        
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        // animationContainerView.isHidden = true
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
    {
        if(message.name == "callbackHandler") {
            if let msg = message.body as? String, msg == "back" {
                self.navigationController?.popViewController(animated: true)
            }
            if let msg = message.body as? String, msg == "next" {
                appDelegateObject().startIndicator()
                DispatchQueue.main.asyncAfter(deadline: DispathTimeDuration().kLoadingDuration) {
                    appDelegateObject().stopIndicator()
                    
                    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BookConfirmedViewController")
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            print("Launch my Native Camera")
        }
    }

}
