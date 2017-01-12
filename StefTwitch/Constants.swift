//
//  Constants.swift
//  StefTwitch
//
//  Created by Andy Stef on 11/21/16.
//  Copyright © 2016 Andy Stef. All rights reserved.
//

import Foundation

//Twitch API URL's
let TWITCH_URL_TOP_GAMES = "https://api.twitch.tv/kraken/games/top?limit=50&client_id=cxkcs4bag1rluipax48qb85gwkn35jw"

let TWITCH_URL_STREAMS_BASE = "https://api.twitch.tv/kraken/streams?game="

let TWITCH_URL_STREAMS_CLIENT_ID = "&client_id=cxkcs4bag1rluipax48qb85gwkn35jw"

let TWITCH_URL_EMBED_BASE = "https://www.twitch.tv/"
let TWITCH_URL_EMBED = "/embed"

let TWITCH_URL_STREAM_DEEP_LINK = "twitch://open?stream="

typealias DownloadComplete = () -> ()
