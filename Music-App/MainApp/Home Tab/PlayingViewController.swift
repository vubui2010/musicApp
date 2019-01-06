//
//  SecondViewController.swift
//  Music-App
//
//  Created by Vu Bui on 12/7/18.
//  Copyright © 2018 Vu Bui. All rights reserved.
//

import UIKit
import AVFoundation
class PlayingViewController: UIViewController, AVAudioPlayerDelegate {
    var timeRunning = 0.0
    
    @IBOutlet weak var nameOfSinger: UILabel!
    @IBOutlet weak var nameOfSongPlaying: UILabel!
    @IBOutlet weak var imgInfoOfSong: UIImageView!
    
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var timeOfSongLbl: UILabel!
    @IBOutlet weak var slideTimeOfSong: UISlider!
    
    @IBAction func btnHideExpand(_ sender: UIButton) {
        
        self.dismiss(animated: false)
    }
    @IBOutlet weak var timePlayingOfSong: UILabel!
    
    
    @IBAction func playSong(_ sender: UIButton) {
        if(avPlayer?.rate == 0)
        {
            avPlayer!.play()
            playBtn.setImage(UIImage(named: "pause.png"), for: UIControl.State.normal)
        }
        else {
            avPlayer!.pause()
            playBtn.setImage(UIImage(named: "play.png"), for: UIControl.State.normal)
        }
    }
    
    
    
    @IBAction func ToPreviousSong(_ sender: UIButton) {
        if indexOfSong > 0
        {
            playCurrentSong(indexSong: indexOfSong - 1)
            indexOfSong-=1
            nameOfSongPlaying.text = DataBaiHat[indexOfSong]["TenBH"] as? String
            
        }
        else if(indexOfSong == 0)
        {
           
            playCurrentSong(indexSong: songList.count - 1)
            indexOfSong = songList.count - 1
            nameOfSongPlaying.text = DataBaiHat[indexOfSong]["TenBH"] as? String
        }
    }
    @IBAction func ToNextSong(_ sender: UIButton) {
        if (indexOfSong < songList.count - 1 )
        {
            playCurrentSong(indexSong: indexOfSong + 1)
            indexOfSong+=1
            nameOfSongPlaying.text = DataBaiHat[indexOfSong]["TenBH"] as? String
        }
        else if(indexOfSong == songList.count - 1 )
        {
            playCurrentSong(indexSong: 0)
            indexOfSong = 0
            nameOfSongPlaying.text = DataBaiHat[indexOfSong]["TenBH"] as? String
        }
    }
    
    @objc func changeSliderValuaFollowPlayingTime(){
        
        //let curValue = Float(audioPlayer.currentTime)//change offline mode
       let currentItem = avPlayer?.currentItem
        
         let curTime: CMTime = (currentItem?.currentTime())!
            
        let seconds: Float64 = CMTimeGetSeconds(curTime)
        slideTimeOfSong.value = Float(seconds)
        timeRunning = Double(slideTimeOfSong.value)
        timePlayingOfSong.text = String(format: "%02d", Int(timeRunning / 60)) +  ":" + String(format: "%02d",Int(timeRunning) % 60)
            
        
    }
    
    @IBAction func changeTimePlaying(_ sender: UISlider) {
        let seconds : Int64 = Int64(slideTimeOfSong.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        avPlayer!.seek(to: targetTime)
        if avPlayer!.rate == 0
        {
            avPlayer?.play()
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Set up time for slide and name of song
        
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let urlSong = URL(string: songList[indexOfSong])
        let playerItem:AVPlayerItem = AVPlayerItem(url: urlSong!)
        playBtn.setImage(UIImage(named: "pause.png"), for: UIControl.State.normal)
        slideTimeOfSong.minimumValue = 0
        
        nameOfSinger.text = DataBaiHat[indexOfSong]["TenCS"] as? String
        nameOfSongPlaying.text = DataBaiHat[indexOfSong]["TenBH"] as? String
//        let url = URL(string: (TableData[indexOfSong]["HinhBH"] as? String)!)
//        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//        self.imgInfoOfSong.image = UIImage(data: data!)
        
        let duration: CMTime = (playerItem.asset.duration)
        let seconds: Float64 = CMTimeGetSeconds(duration)
        
        slideTimeOfSong.maximumValue = Float(seconds)
        timeOfSongLbl.text = String(format: "%02d", Int(seconds / 60)) +  ":" + String(format:"%02d",Int(seconds) % 60)
        
        slideTimeOfSong.isContinuous = true
        slideTimeOfSong.tintColor = UIColor.green
        
        slideTimeOfSong.addTarget(self, action: #selector(PlayingViewController.changeTimePlaying(_:)), for: .valueChanged)
        if( avPlayer?.rate != 0){
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeSliderValuaFollowPlayingTime), userInfo: nil, repeats: true)
        }else{
            timeRunning = 0
            timePlayingOfSong.text = String(format: "%02d", Int(timeRunning / 60)) +  ":" + String(format: "%02d",Int(timeRunning) % 60)
        }
        
    }
    func playCurrentSong(indexSong: Int)
    {
        do
        {
            let urlSong = URL(string: songList[indexSong])
            let playerItem:AVPlayerItem = AVPlayerItem(url: urlSong!)
            avPlayer = AVPlayer(playerItem: playerItem)
            avPlayer!.play()
            
        }
        catch
        {
            print(error)
        }
    }
    func catchEventWhenPrepareFinishCurrentSong(){
        audioPlayer.delegate = self
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

