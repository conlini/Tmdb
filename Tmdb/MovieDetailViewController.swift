//
//  MovieDetailViewController.swift
//  Tmdb
//
//  Created by adbhasin on 07/11/17.
//  Copyright © 2017 conlini. All rights reserved.
//

import UIKit

class MovieDetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellid = "header"
    
    var movie: Movie? {
        didSet {
            navigationItem.title = movie?.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(HeaderCell.self, forCellWithReuseIdentifier: cellid)
        collectionView?.backgroundColor = UIColor.red
        
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! HeaderCell
        cell.backgroundColor = UIColor.blue
        
        
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height : CGFloat = 190
        return CGSize(width: view.frame.width, height: height)
    }
    
    
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var dictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            dictionary["v\(index)"] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary))
    }
}

class HeaderCell: UICollectionViewCell {
    
    let movieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie Title"
        label.font = UIFont(name: "Helvetica", size: CGFloat(24))
        
        //        label.backgroundColor = UIColor.red
        return label
    }()
    let movieImage: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "blankImage")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let synopis : UILabel = {
        let label = UILabel()
        label.text = "blah blah blah blah blah blah blah blahblah blah blah blahblah blah blah blahblah blah blah blahblah blah blah blahblah blah blah and mary had a little lamp and mary had a little lamp"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 8
        label.font = UIFont(name: "Helvetica", size: CGFloat(14))
        //        label.backgroundColor = UIColor.blue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.blue
//        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func setupView() {
        addSubview(movieTitle)
        addSubview(movieImage)
        addSubview(synopis)
        
        //        view.addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: movieTitle)
        //        view.addConstraintsWithFormat(format: "H:|, views: <#T##UIView...##UIView#>)
        addConstraintsWithFormat(format: "H:|-4-[v0(125)]-10-[v1]-4-|", views: movieImage, movieTitle)
        addConstraintsWithFormat(format: "V:|-4-[v0]|", views: movieTitle)
        addConstraintsWithFormat(format: "V:|-80-[v0(125)]", views: movieImage)
        addConstraintsWithFormat(format: "V:|-[v0]-4-[v1]|", views: movieImage, synopis)
    }
    

}
