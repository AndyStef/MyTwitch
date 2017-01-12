//
//  ChannelViewController.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/22/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import UIKit
import WebKit

class ChannelViewController: UIViewController {

    var stream: Stream!
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)

        let urlString = TWITCH_URL_EMBED_BASE + stream.broadcasterName + TWITCH_URL_EMBED

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
