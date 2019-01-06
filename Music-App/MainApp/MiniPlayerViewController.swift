//
//  MiniPlayerViewController.swift
//  MusicApp
//
//  Created by Vu Bui on 1/1/19.
//  Copyright © 2019 Vu Bui. All rights reserved.
//

import UIKit
import AVFoundation
protocol MiniPlayerDelegate: class {
    func expandSong(song: Song)
}

class MiniPlayerViewController: UIViewController{
    var choosedByOne: Int = 0  // 1 if choosed Mixsong in HomeTab, 2 if choosed DataSong
    var listSong : listOfSong?
    var currentDataSong:[[String:Any]] = [[String:Any]]()
     weak var delegate: MiniPlayerDelegate?
    
    @IBOutlet weak var infoNameSong: UILabel!
    @IBOutlet weak var infoNameSinger: UILabel!
    @IBOutlet weak var btnToPrevious: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnToNext: UIButton!
    
    
    @IBAction func ToPreviousSong(_ sender: UIButton) {
        if indexOfSong > 0
        {
            playCurrentSong(indexSong: indexOfSong - 1)
            indexOfSong-=1
            infoNameSong.text = currentDataSong[indexOfSong]["TenBH"] as? String
            
        }
        else if(indexOfSong == 0)
        {
            
            playCurrentSong(indexSong: currentDataSong.count - 1)
            indexOfSong = currentDataSong.count - 1
            infoNameSong.text = currentDataSong[indexOfSong]["TenBH"] as? String
        }
    }
    
    @IBAction func PlayOrStop(_ sender: UIButton) {
        if(avPlayer?.rate == 0)
        {
            avPlayer!.play()
            btnPlay.setImage(UIImage(named: "pause.png"), for: UIControl.State.normal)
        }
        else {
            avPlayer!.pause()
            btnPlay.setImage(UIImage(named: "play.png"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func ToNextSong(_ sender: UIButton) {
        if (indexOfSong < currentDataSong.count - 1 )
        {
            playCurrentSong(indexSong: indexOfSong + 1)
            indexOfSong+=1
            infoNameSong.text = currentDataSong[indexOfSong]["TenBH"] as? String
        }
        else if(indexOfSong == currentDataSong.count - 1 )
        {
            playCurrentSong(indexSong: 0)
            indexOfSong = 0
            infoNameSong.text = currentDataSong[indexOfSong]["TenBH"] as? String
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(isChoose: -1, title: "", artist: "")
        
        // Do any additional setup after loading the view.
    }
    
    
    func playCurrentSong(indexSong: Int)
    {
        do
        {
            let urlSong = URL(string: currentDataSong[indexSong]["LinkBH"] as! String)
            let playerItem:AVPlayerItem = AVPlayerItem(url: urlSong!)
            avPlayer = AVPlayer(playerItem: playerItem)
            avPlayer!.play()
            
        }
        catch
        {
            print(error)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func expandSong()
    {
        guard let expandScreen = storyboard?.instantiateViewController(withIdentifier: "playingscreen") as? PlayingViewController else {
            assertionFailure("No view can expand")
            return
        }
        present(expandScreen, animated: false)
    }
    
    @IBAction func tapMiniPLayer(_ sender: UITapGestureRecognizer) {
        expandSong()
    }
    
}
extension MiniPlayerViewController{
    func configure(isChoose: Int, title: String, artist: String) {
        if (isChoose != -1){
            infoNameSong.text = title
            infoNameSinger.text = artist
            btnPlay.setImage(UIImage(named: "pause.png"), for: UIControl.State.normal)
            
    }
    else {
            infoNameSong.text = nil
           infoNameSinger.text = nil
        }
      
 }
}

