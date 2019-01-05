//
//  PlaylistTabViewController.swift
//  MusicApp
//
//  Created by Vu Bui on 1/3/19.
//  Copyright © 2019 Vu Bui. All rights reserved.
//

import UIKit

class PlaylistTabViewController: UIViewController {

    @IBOutlet weak var PlaylistTabCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PlaylistTabViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return DataPlaylist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playlistcell", for: indexPath) as! PlaylistTabCollectionViewCell
        
        // Configure the cell
        let url = URL(string: DataPlaylist[indexPath.row]["HinhPL"] as! String )
        ImageService.getImage(withURL: url! ){ image in
            cell.imgShowPLaylist.image = image
            cell.infoNamePlaylist.text = DataPlaylist[indexPath.row]["TenPL"] as? String
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mhlistsong = sb.instantiateViewController(withIdentifier: "showListOfSong") as! listOfSong
        mhlistsong.itemSelected = DataPlaylist[indexPath.row]["idPL"] as! String
        mhlistsong.boolSelectedAlbumOrPlaylist = 2
    self.navigationController?.pushViewController(mhlistsong, animated: true)
    }
}
