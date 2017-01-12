//
//  StreamsViewController.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/22/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import UIKit

class StreamsViewController: UIViewController {

    @IBOutlet weak var streamsTableView: UITableView!

    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = game.gameName!

        streamsTableView.delegate = self
        streamsTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        StreamDataService.instance.downloadStreamsForGame(game) { 
            for stream in StreamDataService.instance.streams {
                stream.downloadStreamImage(completed: { 
                    self.streamsTableView.reloadData()
                })
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

        StreamDataService.instance.removeAllStream()
    }

    func openStream(_ stream: Stream) {
        let alert = UIAlertController(title: "Open stream in StefTwitch or in official Twitch app?", message: "Official Twitch app must be installed for latter option", preferredStyle: .alert)

        let openInStefTwitchAction = UIAlertAction(title: "StefTwitch", style: .default) { (action) in
            self.performSegue(withIdentifier: "channelShowViewController", sender: stream)
        }

        let openInTwitchAppAction = UIAlertAction(title: "Twitch", style: .default) { (action) in
            self.openStreamInTwitchApp(stream)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(openInStefTwitchAction)
        alert.addAction(openInTwitchAppAction)
        alert.addAction(cancelAction)

        present(alert, animated: true, completion: nil)
    }

    func openStreamInTwitchApp(_ stream: Stream) {
        let streamString = TWITCH_URL_STREAM_DEEP_LINK + stream.broadcasterName

        if let streamUrl = URL(string: streamString) {
            if UIApplication.shared.canOpenURL(streamUrl) {
                UIApplication.shared.open(streamUrl, options: [:], completionHandler: nil)
            }
        }
    }

    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "channelShowViewController" {
            if let channelViewController = segue.destination as? ChannelViewController {
                if let stream = sender as? Stream {
                    channelViewController.stream = stream
                }
            }
        }
    }
}

extension StreamsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StreamDataService.instance.streams.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = streamsTableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as? StreamTableViewCell {

            let stream = StreamDataService.instance.streams[indexPath.row]
            cell.configureCell(stream)

            return cell
        } else {
            return StreamTableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let stream = StreamDataService.instance.streams[indexPath.row]

        openStream(stream)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (streamsTableView.bounds.width / 16) * 9
    }
}
