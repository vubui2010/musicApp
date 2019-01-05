//
//  MiniPlayerViewController.swift
//  MusicApp
//
//  Created by Vu Bui on 1/1/19.
//  Copyright © 2019 Vu Bui. All rights reserved.
//

import UIKit
protocol MiniPlayerDelegate: class {
    func expandSong(song: Song)
}

class MiniPlayerViewController: UIViewController, SongSubscribers {

    
    var currentSong: Song?
    weak var delegate: MiniPlayerDelegate?
    
    @IBOutlet weak var infoNameSong: UILabel!
    @IBOutlet weak var infoNameSinger: UILabel!
    
    @IBAction func ToPreviousSong(_ sender: UIButton) {
    }
    
    @IBAction func PlayOrStop(_ sender: UIButton) {
    }
    
    @IBAction func ToNextSong(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(isChoose: -1, title: "", artist: "")
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
extension MiniPlayerViewController{
    func configure(isChoose: Int, title: String, artist: String) {
        if (isChoose != -1){
            infoNameSong.text = title
            infoNameSinger.text = artist
    }
    else {
            infoNameSong.text = nil
           infoNameSinger.text = nil
        }
      
 }
}
extension MiniPlayerViewController{
    
}

