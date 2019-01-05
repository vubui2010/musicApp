//
//  SongSubscriber.swift
//  MusicApp
//
//  Created by Vu Bui on 1/5/19.
//  Copyright © 2019 Vu Bui. All rights reserved.
//

import Foundation

protocol SongSubscribers: class {
    var currentSong: Song? {get set}
}
