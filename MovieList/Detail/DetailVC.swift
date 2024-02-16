//
//  DetailVC.swift
//  MovieList
//
//  Created by aldo on 16/02/24.
//

import UIKit
import youtube_ios_player_helper
import Kingfisher

protocol DetailViewInterface {
    var id: Int? { get set }
    
    var presenter: DetailPresenterInterface? { get set }
    var detailMovie: DetailMovie? { get }
    var movieVideos: DetailMovieVideo? { get }
    var movieReviews: ReviewMovie? { get }
    
    func setupView()
    func showView(with result: DetailMovie)
    func showVideo(with result: DetailMovieVideo)
    func showReviews(with result: ReviewMovie)

}

class DetailVC: UIViewController, DetailViewInterface, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var presenter: DetailPresenterInterface?
    
    var detailMovie: DetailMovie?
    var movieVideos: DetailMovieVideo?
    var movieReviews: ReviewMovie?
    var id: Int?
    
    func setupView() {
        collectionView.register(UINib(nibName: ReviewsCell.identifier, bundle: nil), forCellWithReuseIdentifier: ReviewsCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        if let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
           collectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        presenter?.fetchDatas(with: id!, with: "en-US")
        presenter?.fetchVideos(with: id!, with: "en-US")
        presenter?.fetchReviews(with: id!, with: "en-US", with: 1)
    }
    
    func showView(with result: DetailMovie) {
        DispatchQueue.main.async {
            self.detailMovie = result
            self.setLabel()
        }
    }
    
    func showVideo(with result: DetailMovieVideo) {
        DispatchQueue.main.async {
            self.movieVideos = result
            self.setVideo()
        }
    }
    
    func showReviews(with result: ReviewMovie) {
        DispatchQueue.main.async {
            self.movieReviews = result
            for i in result.results! {
                self.ReviewsStored.append([i.author_details?.avatar_path ?? "",i.author_details?.username ?? "", i.author_details?.rating ?? 0, i.created_at ?? "", i.content ?? ""])
            }
            self.collectionView.reloadData()
        }
    }
    

    @IBOutlet weak var playerView: YTPlayerView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var lbl2: UILabel!
    
    @IBOutlet weak var lbl3: UILabel!
    
    @IBOutlet weak var lbl4: UILabel!
    
    @IBOutlet weak var lbl5: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var genresList: String = ""
    var currentPage: Int?
    var ReviewsStored: [[Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.minimumScaleFactor = 0.5
        currentPage = 1
        presenter?.notifyViewDidLoad()

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ReviewsStored.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCell.identifier, for: indexPath) as! ReviewsCell
        
        cell.contentLbl.text = (ReviewsStored[indexPath.item][4] as? String)?.htmlToString
        cell.titleLbl.text = ReviewsStored[indexPath.item][1] as? String
        cell.secondLbl.text = "\(ReviewsStored[indexPath.item][2] as? Int ?? 0)"
        cell.thirdLbl.text = (ReviewsStored[indexPath.item][3] as? String)?.convertToDate()
        
        if ReviewsStored[indexPath.item][0] as? String != "" {
            
            let imageUrl = "https://image.tmdb.org/t/p/w500\(ReviewsStored[indexPath.item][0] as? String ?? "")"
    
            cell.iconView.kf.setImage(with: imageUrl.asUrl)
            
        }
        else {
            cell.iconView.image = UIImage(systemName: "person.circle.fill")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == ReviewsStored.count - 2 &&  movieReviews?.total_pages != currentPage {
            currentPage = (currentPage ?? 1) + 1
            presenter?.fetchReviews(with: id!, with: "en-US", with: currentPage!)
        }
    }
    
    
    func setLabel() {
        titleLbl.text = detailMovie?.title ?? ""
        lbl2.text = detailMovie?.release_date ?? ""
        lbl3.text = "Revenue : " + (detailMovie?.revenue?.createCurrencyString() ?? "")
        
        for i in 0...((detailMovie?.genres!.count)! - 1) {
            if i == ((detailMovie?.genres!.count)! - 1) {
                genresList = genresList + "\(detailMovie?.genres?[i].name! ?? "")"
            }
            else{
                genresList = genresList + "\(detailMovie?.genres?[i].name! ?? ""), "
            }
            
        }
        lbl4.text = genresList
        lbl5.text = "User Reviews"
        
    }
    
    func setVideo() {
        
        for i in movieVideos!.results! {
            if i.site == "YouTube" && i.type == "Trailer" {
                playerView.load(withVideoId: i.key ?? "", playerVars: ["playsinline" : 1])
            }
        }
        
    }


}
