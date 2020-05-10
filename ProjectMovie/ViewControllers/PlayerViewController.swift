//
//  PlayerViewController.swift
//  ProjectMovie
//
//  Created by Jerry Purnama Maulid on 11/05/20.
//  Copyright © 2020 Jerry Purnama Maulid. All rights reserved.
//

import UIKit
import WebKit

class PlayerViewController: UIViewController {
    @IBOutlet var webView: WKWebView!

    var urlString: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = urlString {
            loadYoutube(videoID: url)
        }
    }

    func loadYoutube(videoID: String) {
        guard let youtubeURL = URL(string: videoID) else { return }
        let urlReq = URLRequest(url: youtubeURL)
        webView.load(urlReq)
    }
}
