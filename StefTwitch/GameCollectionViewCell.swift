//
//  GameCollectionViewCell.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/21/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gameImageView: UIImageView!

    func configureCell(_ game: Game) {
        if game.gameImage != nil {
            gameImageView.image = game.gameImage
            gameImageView.layer.cornerRadius = 10
            gameImageView.layer.masksToBounds = true
        }
    }
}
