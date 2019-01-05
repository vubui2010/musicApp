//
//  TopicAndGenreViewController.swift
//  MusicApp
//
//  Created by Vu Bui on 1/3/19.
//  Copyright © 2019 Vu Bui. All rights reserved.
//

import UIKit

class TopicAndGenreViewController: UIViewController {

    @IBOutlet weak var TopicAndGenreCollectionView: UICollectionView!
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
extension TopicAndGenreViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataChude.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topiccell", for: indexPath) as! TopicAndGenreCollectionViewCell
        let url = URL(string: DataChude[indexPath.row]["HinhCD"] as! String )
        ImageService.getImage(withURL: url! ){ image in
            cell.imgShowTopicAndGenre.image = image
        }
        return cell
    }
    
    
}
