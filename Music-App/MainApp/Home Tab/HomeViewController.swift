//
//  HomeViewController.swift
//  Music-App
//
//  Created by Vu Bui on 12/8/18.
//  Copyright © 2018 Vu Bui. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

var audioPlayer:AVAudioPlayer! //Su dung khi choi nhac offline
var avPlayer: AVPlayer? // Su dung khi choi nhac tu URL online
var playerItem:AVPlayerItem?
var indexOfSong = -1 // Dung de danh dau lua chon bai hat nao de lay thong tin cho de

var timer: Timer?  //Dieu khien, hien thi thoi gian cua bai hat
var DataBaiHat: [[String: Any]] = [[String: Any]] ()  //Parse data tu bang baihat luu vao TableData
var DataAlbum:[[String: Any]] = [[String: Any]]()
var DataPlaylist:[[String: Any]] = [[String: Any]]()
var DataChude:[[String:Any]] = [[String:Any]]()

var songList: [String] = []
class HomeViewController: UIViewController{
    
    
    var miniPlayer: MiniPlayerViewController?
    
    @IBOutlet weak var PlayListCollectionView: UICollectionView!
    @IBOutlet weak var AlbumCollectionView: UICollectionView!
    @IBOutlet weak var MixSongTableView: UITableView!
    
   
    
    
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        
       getInfoForAlbum()
        getInfoForSongs()
        getInfoForPLaylist()
        getInfoForTopicAndGenre()
        // Do any additional setup after loading the view.
        print(DataAlbum)
        print(DataAlbum.count)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MiniPlayerViewController {
            miniPlayer = destination
        }
    }
    
   public func getInfoForSongs(){
        
        db.collection("baihat").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    DataBaiHat.append(document.data() )
                    songList.append(document.data()["LinkBH"] as! String)
                    
                    
                }
                self.MixSongTableView.reloadData()
                }
            }
    }
    func getInfoForAlbum()
    {
        db.collection("album").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    DataAlbum.append((document.data() ))
                   
                }
                self.AlbumCollectionView.reloadData()
            }
        }
    }
    
    func getInfoForPLaylist()
    {
        db.collection("playlist").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    DataPlaylist.append(document.data())
                    
                }
                self.PlayListCollectionView.reloadData()
            }
        }
    }
    func getInfoForTopicAndGenre()
    {
        db.collection("chude").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    DataChude.append(document.data())
                    
                }
                
            }
        }
    }

}
extension HomeViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.PlayListCollectionView)
        {
            return DataPlaylist.count
        }else{
            return DataAlbum.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.AlbumCollectionView {
            let collectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectcell", for: indexPath) as? AlbumCollectionViewCell
        
        let url = URL(string: DataAlbum[indexPath.row]["HinhAB"] as! String)
        ImageService.getImage(withURL: url! ){ image in
            collectCell?.imgAlbum.image = image
            collectCell!.infoOfAlbum?.text = DataAlbum[indexPath.row]["TenAB"] as? String
        }
        return collectCell!
        
    }
        else{
            let collectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistcell", for: indexPath) as? PlayListCollectionViewCell
            
            let url = URL(string: DataPlaylist[indexPath.row]["HinhPL"] as! String )
            ImageService.getImage(withURL: url! ){ image in
                collectCell?.imgPlaylist.image = image
                collectCell?.infoPlaylist.text = DataPlaylist[indexPath.row]["TenPL"] as? String
            }
            return collectCell!
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.AlbumCollectionView {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let mhlistsong = sb.instantiateViewController(withIdentifier: "showListOfSong") as! listOfSong
            
            mhlistsong.itemSelected = DataAlbum[indexPath.row]["idAB"] as! String
            mhlistsong.boolSelectedAlbumOrPlaylist = 1
            self.navigationController?.pushViewController(mhlistsong, animated: true)
            print(indexPath.row)
            
        }
        else{
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let mhlistsong = sb.instantiateViewController(withIdentifier: "showListOfSong") as! listOfSong
            mhlistsong.itemSelected = DataPlaylist[indexPath.row]["idPL"] as! String
            mhlistsong.boolSelectedAlbumOrPlaylist = 2
            self.navigationController?.pushViewController(mhlistsong, animated: true)
            print(indexPath.row)
            }
          
        }
    
}
extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBaiHat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mixsongcell", for: indexPath) as! MixSongHomePageTableViewCell
        cell.textLabel?.text = DataBaiHat[indexPath.row]["TenBH"] as? String
            cell.detailTextLabel?.text = DataBaiHat[indexPath.row]["TenCS"] as? String
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        //Play online
        let urlSong = URL(string: DataBaiHat[indexPath.row]["LinkBH"] as! String )
        let playerItem:AVPlayerItem = AVPlayerItem(url: urlSong!)
        avPlayer = AVPlayer(playerItem: playerItem)
        avPlayer?.rate = 1.0
        avPlayer!.play()
        indexOfSong = indexPath.row
        let title = DataBaiHat[indexOfSong]["TenBH"] as! String
        let artist = DataBaiHat[indexOfSong]["TenCS"] as! String
        
        miniPlayer?.configure(isChoose: 1, title: title, artist: artist )
        
        print(DataBaiHat[indexPath.row]["TenBH"] as! String)
        
    }
    
}
