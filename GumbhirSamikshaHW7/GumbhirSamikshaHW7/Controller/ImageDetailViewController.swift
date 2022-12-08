//
//  ImageDetailViewController.swift
//  GumbhirSamikshaHW7
//
//  Created by Samiksha Gumbhir on 11/7/22.
//

import UIKit
import WebKit

class ImageDetailViewController:  UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var loadingIcon: UIActivityIndicatorView!
    
    public var selectedItem: Image!
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: selectedItem.urls.full)
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingIcon.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loadingIcon.stopAnimating()
    }
    
    func webView(_ webView: WKWebView,
                 didFailProvisionalNavigation navigation: WKNavigation!,
                 withError error: Error) {
        loadingIcon.stopAnimating()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
