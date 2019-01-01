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



class ListViewController: UIViewController, UITableViewDelegate ,UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        myTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OneSingTableViewCell
       // cell.nameSong.text = songList[indexPath.row]
        
//        let url = URL(string: (TableData[indexPath.row]["HinhBH"] as? String)!)
//        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//        cell.imgSong.image = UIImage(data: data!);
        
        
            cell.nameSong.text = DataBaiHat[indexPath.row]["TenBH"] as? String
            cell.nameSinger.text = DataBaiHat[indexPath.row]["TenCS"] as? String
            let url = URL(string: (DataBaiHat[indexPath.row]["HinhBH"] as? String)! )
            ImageService.getImage(withURL: url! ){ image in
                cell.imgSong.image = image
            }
            
        

        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //Play online
        let urlSong = URL(string: songList[indexPath.row])
        let playerItem:AVPlayerItem = AVPlayerItem(url: urlSong!)
        avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer?.rate = 1.0
        avPlayer!.play()
        indexOfSong = indexPath.row
        
}
}
  
    
    

