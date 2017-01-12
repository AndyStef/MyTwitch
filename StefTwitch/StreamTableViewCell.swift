//
//  StreamTableViewCell.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/22/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import UIKit

class StreamTableViewCell: UITableViewCell {
    @IBOutlet weak var streamImageView: UIImageView!
    @IBOutlet weak var broadcasterLabel: UILabel!
    @IBOutlet weak var streamNameLabel: UILabel!
    @IBOutlet weak var viewersCountLabel: UILabel!

    func configureCell(_ stream: Stream) {
        broadcasterLabel.text = stream.broadcasterName
        streamNameLabel.text = stream.streamTitle

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        viewersCountLabel.text = "\(formatter.string(from: NSNumber(value: stream.streamViewerCount))!) viewers"

        if stream.streamImage != nil {
            streamImageView.image = stream.streamImage
        }
    }
}
