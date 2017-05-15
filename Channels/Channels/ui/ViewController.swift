//
//  ViewController.swift
//  Channels
//
//  Created by Calvin on 15/05/2017.
//  Copyright © 2017 rmo. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON

class ViewController: BaseViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var mapView: MKMapView!
  
  var locationManager = CLLocationManager()
  var channelDataSource = [Channel]()

  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    buildDataSource()
    
    
    mapView.delegate = self
    mapView.showsUserLocation = true
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  func buildDataSource() {
    let apiManager = AppDelegate.getDelegate().context.apiManager
    
    apiManager.get(url: AppConf.API.url) { dataResponse in
      if let data = dataResponse.data {
        let json = JSON(data: data)
        
        if let channelArray = json["channels"].array {
          for channelJson in channelArray {
            
            var spots = [Spot]()
            
            if let spotArray = channelJson["spots"].array {
              for spotJson in spotArray {
                var subtitles = [Subtitle]()
                if let subtitleArary = spotJson["subtitles"].array {
                  for subtitleJson in subtitleArary {
                    let subtitle = Subtitle(id: subtitleJson["id"].stringValue,
                                            language: subtitleJson["language"].stringValue,
                                            url: subtitleJson["url"].stringValue)
                    subtitles.append(subtitle)
                  }
                }
                
                let spot = Spot(id: spotJson["id"].stringValue,
                                title: spotJson["title"].stringValue,
                                information: spotJson["information"].stringValue,
                                videoUrl: spotJson["video_url"].stringValue,
                                coordinates: (spotJson["coordinates"][0].floatValue, spotJson["coordinates"][1].floatValue),
                                subtitles: subtitles)
                
                spots.append(spot)
              }
            }
            let channel = Channel(id: channelJson["id"].stringValue,
                                  name: channelJson["name"].stringValue,
                                  spots: spots)
            self.channelDataSource.append(channel)
            
            self.tableView.reloadData()
          }
        }
      } else {
        print("error")
      }
    }
  }
  

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return channelDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: ChannelTableViewCellIdentifier, for: indexPath) as? ChannelTableViewCell else {
      return UITableViewCell()
    }
    
    cell.configure(channelDataSource[indexPath.item])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
  }
}

