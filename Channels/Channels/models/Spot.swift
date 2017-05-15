//
//  Spot.swift
//  Channels
//
//  Created by Calvin on 15/05/2017.
//  Copyright © 2017 rmo. All rights reserved.
//

struct Spot {
  var id: String
  var title: String
  var information: String
  var videoUrl: String
  var coordinates: (Float, Float)
  var subtitles = [Subtitle]()
}
