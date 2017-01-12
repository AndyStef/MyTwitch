//
//  Stream.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/22/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import UIKit
import Alamofire

class Stream {
    var broadcasterName: String!
    var streamTitle: String!
    var streamViewerCount: Double!
    var streamImage: UIImage?
    var streamImageUrl: String!

    init(name: String, title: String, viewerCount: Double, imageUrl: String) {
        self.broadcasterName = name
        self.streamTitle = title
        self.streamViewerCount = viewerCount
        self.streamImageUrl = imageUrl
    }

    func downloadStreamImage(completed: @escaping DownloadComplete) {
        request(self.streamImageUrl).responseData { (response) in
            if let data = response.result.value {
                if let image = UIImage(data: data) {
                    self.streamImage = image
                }
            }

            completed()
        }
    }
}
