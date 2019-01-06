//
//  ViewController.swift
//  Music-App
//
//  Created by Vu Bui on 12/5/18.
//  Copyright © 2018 Vu Bui. All rights reserved.
//

import UIKit
import AVFoundation


import Firebase



class listOfSong: UIViewController, UITableViewDelegate ,UITableViewDataSource{
    
    var miniPlayer: MiniPlayerViewController?
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var Miniplayer: UIView!
    
    
   public var DataSong: [[String:Any]] = [[String:Any]]()
    var itemSelected: String = ""
    var boolSelectedAlbumOrPlaylist: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(boolSelectedAlbumOrPlaylist == 1){
            
       for item in DataBaiHat
       {
            if(item["idAB"] as! String == itemSelected)
            {
                DataSong.append(item)
            }
            }
        }
        else if(boolSelectedAlbumOrPlaylist == 2)
        {
            
            for item in DataBaiHat
            {
                if (item["idPL"] as! String == itemSelected)
                {
                    DataSong.append(item)
                }
            }
        }
        
        myTableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MiniPlayerViewController {
            miniPlayer = destination
        }}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSong.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OneSingTableViewCell
       // cell.nameSong.text = songList[indexPath.row]
        
//        let url = URL(string: (TableData[indexPath.row]["HinhBH"] as? String)!)
//        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//        cell.imgSong.image = UIImage(data: data!);
        
        
            cell.nameSong.text = DataSong[indexPath.row]["TenBH"] as? String
            cell.nameSinger.text = DataSong[indexPath.row]["TenCS"] as? String
            let url = URL(string: (DataSong[indexPath.row]["HinhBH"] as? String)! )
            ImageService.getImage(withURL: url! ){ image in
                cell.imgSong.image = image
            }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //Play online
        let urlSong = URL(string: DataSong[indexPath.row]["LinkBH"] as! String )
        let playerItem:AVPlayerItem = AVPlayerItem(url: urlSong!)
        avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer?.rate = 1.0
        avPlayer!.play()
        indexOfSong = indexPath.row
       
        let title = DataSong[indexPath.row]["TenBH"] as! String
        let artist = DataSong[indexPath.row]["TenCS"] as! String
        
        miniPlayer?.configure(isChoose: 1, title: title, artist: artist )
        miniPlayer?.choosedByOne = 2
        miniPlayer?.currentDataSong = DataSong
        print(DataSong[indexPath.row]["TenBH"] as! String)
        
}
}
  
    
    

