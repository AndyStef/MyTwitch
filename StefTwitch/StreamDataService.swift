//
//  StreamDataService.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/22/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import Foundation
import Alamofire

class StreamDataService {
    static let instance = StreamDataService()

    var streams = [Stream]()

    func downloadStreamsForGame(_ game: Game, completed: @escaping DownloadComplete) {
        var viewerCountDouble: Double!
        var imagePreviewUrlString: String!
        var channelNameString: String!
        var channelStatusString: String!

        let gameString = game.gameName.replacingOccurrences(of: " ", with: "+")
        let url = TWITCH_URL_STREAMS_BASE + gameString + TWITCH_URL_STREAMS_CLIENT_ID

        request(url).responseJSON { (response) in
            if let JSON = response.result.value as? [String : Any] {
                if let streamsArray = JSON["streams"] as? [Dictionary<String, Any>], streamsArray.count > 0 {
                    for i in 0..<streamsArray.count {
                        if let viewerCount = streamsArray[i]["viewers"] as? Double {
                            viewerCountDouble = viewerCount
                        }

                        if let imageDict = streamsArray[i]["preview"] as? [String : Any] {
                            if let imageUrl = imageDict["large"] as? String {
                                imagePreviewUrlString = imageUrl
                            }
                        }

                        if let channelDict = streamsArray[i]["channel"] as? [String : Any] {
                            if let channelName = channelDict["display_name"] as? String {
                                channelNameString = channelName
                            }

                            if let chanelStatus = channelDict["status"] as? String {
                                channelStatusString = chanelStatus
                            }
                        }

                        let stream = Stream(name: channelNameString, title: channelStatusString, viewerCount: viewerCountDouble, imageUrl: imagePreviewUrlString)
                        self.streams.append(stream)
                    }
                }
            }

            completed()
        }
    }

    func removeAllStream() {
        streams.removeAll()
    }
}
