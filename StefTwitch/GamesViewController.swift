//
//  GamesViewController.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/21/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var refreshControl: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Games"
        gamesCollectionView.delegate = self
        gamesCollectionView.dataSource = self

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(GamesViewController.reloadData), for: UIControlEvents.valueChanged)
        gamesCollectionView.insertSubview(refreshControl, at: 0)

        reloadData()
    }

    func reloadData() {
        GameDataService.instance.downloadTopGames {
            for game in GameDataService.instance.games {
                game.downloadGameImage(completed: {
                    self.gamesCollectionView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.refreshControl.endRefreshing()
                })
            }
        }
    }

    //MARK: - Segue 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "streamShowViewController" {
            if let streamViewController = segue.destination as? StreamsViewController {
                if let game = sender as? Game {
                    streamViewController.game = game
                }
            }
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension GamesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GameDataService.instance.games.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as? GameCollectionViewCell {

            let game = GameDataService.instance.games[indexPath.row]
            cell.configureCell(game)

            return cell
        } else {
            return GameCollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let game = GameDataService.instance.games[indexPath.row]
        performSegue(withIdentifier: "streamShowViewController", sender: game)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (gamesCollectionView.bounds.width / 2) - 15
        let height = width * (4 / 3)

        return CGSize(width: width, height: height)
    }
}
