//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by Vu Bui on 1/6/19.
//  Copyright © 2019 Vu Bui. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {

    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
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
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataBaiHat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultsearchcell", for: indexPath) as! SearchResultTableViewCell
        
        
        
        cell.infoTitle.text = DataBaiHat[indexPath.row]["TenBH"] as? String
        cell.infoArtist.text = DataBaiHat[indexPath.row]["TenCS"] as? String
        let url = URL(string: (DataBaiHat[indexPath.row]["HinhBH"] as? String)! )
        ImageService.getImage(withURL: url! ){ image in
            cell.imgCover.image = image
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
extension SearchResultViewController{
        func AlterLayoutSearchBar()
        {
    
            searchBar.sizeToFit()
            searchBar.placeholder = ""
            self.navigationController?.navigationBar.topItem?.titleView = searchBar
        }
}
extension SearchResultViewController:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
       
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}
