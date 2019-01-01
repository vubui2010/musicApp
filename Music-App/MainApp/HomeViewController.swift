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
var songList: [String] = []
var audioPlayer:AVAudioPlayer! //Su dung khi choi nhac offline
var avPlayer: AVPlayer? // Su dung khi choi nhac tu URL online
var playerItem:AVPlayerItem?
var indexOfSong = 0 // Dung de danh dau lua chon bai hat nao de lay thong tin cho de

var timer: Timer?  //Dieu khien, hien thi thoi gian cua bai hat
var DataBaiHat: [[String: Any]] = [[String: Any]] ()  //Parse data tu bang baihat luu vao TableData
var DataChuDe:[String] = []
var DataPlaylist:[String] = []
class HomeViewController: UIViewController{
    
    @IBOutlet weak var PlayListCollectionView: UICollectionView!
    @IBOutlet weak var ThemeCollectionView: UICollectionView!
    
    var db: Firestore!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings
        // Do any additional setup after loading the view.
        print(DataChuDe)
        print(DataChuDe.count)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getInfoForSongs()
        getInfoForThemes()
        getInfoForPLaylist()
    }

    func getInfoForSongs(){
        
        db.collection("baihat").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {                    DataBaiHat.append((document.data()))
                    songList.append(document.data()["LinkBH"] as! String)
                   
                }
                }
            }
    }
    func getInfoForThemes()
    {
        db.collection("chude").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    DataChuDe.append((document.data()["HinhCD"] as! String ))
                   
                }
                self.ThemeCollectionView.reloadData()
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
                    DataPlaylist.append((document.data()["HinhPL"] as! String ))
                    
                }
                self.PlayListCollectionView.reloadData()
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
            return DataChuDe.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.ThemeCollectionView {
            let collectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectcell", for: indexPath) as? ThemesCollectionViewCell
        
        let url = URL(string: DataChuDe[indexPath.row] )
        ImageService.getImage(withURL: url! ){ image in
            collectCell?.imgTheme.image = image
        }
        return collectCell!
        
    }
        else{
            let collectCell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistcell", for: indexPath) as? PlayListCollectionViewCell
            
            let url = URL(string: DataPlaylist[indexPath.row] )
            ImageService.getImage(withURL: url! ){ image in
                collectCell?.imgPlaylist.image = image
            }
            return collectCell!
        }
    }
}