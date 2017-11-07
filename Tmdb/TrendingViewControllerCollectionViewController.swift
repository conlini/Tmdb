//
//  TrendingViewControllerCollectionViewController.swift
//  Tmdb
//
//  Created by adbhasin on 06/11/17.
//  Copyright © 2017 conlini. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TrendingViewControllerCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    static let disovery_Url = "https://api.themoviedb.org/3/discover/movie?api_key=b2ed31075b9ee781c6369b0b55e53440&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page="
    
    var movies = [Movie]()
    var currentPage: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView!.backgroundColor = UIColor(white: 0.95, alpha: 1)
        // Do any additional setup after loading the view.
        loadFromFile(page: currentPage)
        navigationItem.title = "Discover Movies"
        
        collectionView!.alwaysBounceVertical = false
//        navigationItem.
        //        loadDummyData()
    }
    
    
    func loadFromFile(page: Int) {
        
        let url = URL(string: TrendingViewControllerCollectionViewController.disovery_Url + String(page))!
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] (data, response, error) in
            if error != nil {
                return
            }
            do {
                self?.currentPage = page
                guard let data = data else {return }
                let discoveryResults = try JSONDecoder().decode(Result.self, from: data)
                self?.movies += discoveryResults.results
                DispatchQueue.main.sync {
                    self?.collectionView?.reloadData()
                }
//                self?.collectionView?.reloadData()
            } catch let err {
                print(err)
            }
            
            
        }).resume()
        
        //        if let path = Bundle.main.path(forResource: "discover_movies", ofType: "json") {
        //
        //            do {
        //
        //                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
        //                let discoveryResults = try JSONDecoder().decode(Result.self, from: data)
        //                movies = discoveryResults.results
        //
        //            } catch let err {
        //                print(err)
        //            }
        //        }
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        cell.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        cell.movie = movies[indexPath.row]
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height : CGFloat = 190
        return CGSize(width: view.frame.width, height: height)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        let selectedMovie = movies[indexPath.row]
//        let alert = UIAlertController(title: selectedMovie.title, message: selectedMovie.overview, preferredStyle: .alert)
////        alert.title = cell.movie?.title
//        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
        
        let layout = UICollectionViewLayout()
        let movieDetailController = MovieDetailViewController(collectionViewLayout: layout)
        movieDetailController.movie = selectedMovie
        self.navigationController!.pushViewController(movieDetailController, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == movies.count-1 && currentPage < 5 {
            loadFromFile(page: currentPage + 1)
        }
    }
    
}

class MovieCell: UICollectionViewCell {
    
    static let basePosterURL: String = "https://image.tmdb.org/t/p/w185"
    
    let movieTitle : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Movie Title"
        label.font = UIFont(name: "Helvetica", size: CGFloat(30))
        
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
    
    
    var movie: Movie?{
        didSet {
            movieTitle.text = movie?.title
            synopis.text = movie?.overview
            guard let poster = movie?.poster_path else {
                return
            }
            let imgUrlString = MovieCell.basePosterURL +  poster
            let imgUrl: URL = URL(string: imgUrlString)!
            URLSession.shared.dataTask(with: imgUrl, completionHandler: { [weak self] (data, response, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                DispatchQueue.main.async {
                    if let image = UIImage(data: data!) {
                        self?.movieImage.image = image
                        
                    }
                }
                
                
            }).resume()
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(movieTitle)
        addSubview(movieImage)
        addSubview(synopis)
        
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: movieTitle)
        addConstraintsWithFormat(format: "H:|-4-[v0]-5-[v1]-4-|", views: movieImage, synopis)
        addConstraintsWithFormat(format:  "V:|-8-[v0(30)]-[v1]-8-|", views: movieTitle, synopis)
        addConstraintsWithFormat(format: "V:|-8-[v0(30)]-[v1]-8-|", views: movieTitle, movieImage)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-8-[v0(30)]-[v1]-8-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0" : movieTitle, "v1" : movieImage]))
    }
    
}


