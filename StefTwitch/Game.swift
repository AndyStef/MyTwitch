//
//  Game.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/21/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import UIKit
import Alamofire

class Game {

    var gameName: String!
    var gameImageURL: String!
    var gameImage: UIImage?

    init(name: String, imageURL: String) {
        self.gameName = name
        self.gameImageURL = imageURL
    }

    func downloadGameImage(completed: @escaping DownloadComplete) {
        request(self.gameImageURL).responseData { (responce) in
            if let data = responce.result.value {
                if let image = UIImage(data: data) {
                    self.gameImage = image
                }
            }

            completed()
        }
    }
}
