//
//  MoviesViewController.swift
//  TMDB Client
//
//  Created by Roman Samborskyi on 11.07.2024.
//

import UIKit


enum TopTabs: String, CaseIterable {
    case trending, topRated, upcoming
    
    var description: String {
        switch self {
        case .trending:
           return "Trending"
        case .topRated:
           return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}


protocol MovieViewProtocol: AnyObject {
    func show(movies: [Movie], with posters: [Int : UIImage])
    func showGenre(genre: [Genre])
    func showMoviesByGenre(movies: [Movie], with posters: [Int : UIImage])
}

class MoviesViewController: UIViewController {
    //MARK: - property
    var presenter: MoviePresenterProtocol?
    private var movies: [Movie] = []
    private var genres: [Genre] = []
    private var posters: [Int : UIImage] = [:]
    private var moviesByGenre: [Movie] = []
    private var postersByGenre: [Int : UIImage] = [:]
    private var selectedTab: TopTabs = .trending
    private var selectedGenre: Genre = DeveloperPreview.instance.action
    private lazy var scroll: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var topCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = .init(width: UIScreen.main.bounds.width / 3.17, height: 190)
        flow.scrollDirection = .horizontal
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.identifire)
        cell.tag = 0
        return cell
    }()
    private lazy var bottomCollection: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = .init(width: UIScreen.main.bounds.width / 3.17, height: 190)
        flow.scrollDirection = .horizontal
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.identifire)
        cell.tag = 2
        return cell
    }()
    private lazy var topPicker: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = .init(width: UIScreen.main.bounds.width / 3.5, height: 50)
        flow.scrollDirection = .horizontal
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(TopPickerViewCell.self, forCellWithReuseIdentifier: TopPickerViewCell.identifire)
        cell.tag = 1
        return cell
    }()
    private lazy var genrePicker: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = .init(width: UIScreen.main.bounds.width / 4, height: 50)
        flow.scrollDirection = .horizontal
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(GenrePickerCell.self, forCellWithReuseIdentifier: GenrePickerCell.identifire)
        cell.tag = 3
        return cell
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewControllerDidLoad(with: selectedTab)
        presenter?.viewControllerDidLoad(genre: selectedGenre)
        setupLayout()
    }
}
//MARK: - UI layout
private extension MoviesViewController {
    func setupLayout() {
        self.view.backgroundColor = UIColor.customBackground
        self.navigationItem.title = "Movies"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupScrollView()
        setupPickerView()
        setupTopCollectionCell()
        setupGenrePickerView()
        setupBottomCollectionCell()
    }
    func setupScrollView() {
        let margins = self.view.layoutMarginsGuide
        self.view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.bounces = true
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: margins.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    func setupTopCollectionCell() {
        self.scroll.addSubview(topCollection)
        topCollection.translatesAutoresizingMaskIntoConstraints = false
        topCollection.backgroundColor = UIColor.customBackground
        topCollection.showsHorizontalScrollIndicator = false
        topCollection.dataSource = self
        topCollection.delegate = self
        
        NSLayoutConstraint.activate([
            topCollection.topAnchor.constraint(equalTo: topPicker.bottomAnchor, constant: 5),
            topCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 5),
            topCollection.heightAnchor.constraint(equalToConstant: 190),
            topCollection.widthAnchor.constraint(equalTo: scroll.widthAnchor)
        ])
    }
    func setupBottomCollectionCell() {
        self.scroll.addSubview(bottomCollection)
        bottomCollection.translatesAutoresizingMaskIntoConstraints = false
        bottomCollection.backgroundColor = UIColor.customBackground
        bottomCollection.showsHorizontalScrollIndicator = false
        bottomCollection.dataSource = self
        bottomCollection.delegate = self
        
        NSLayoutConstraint.activate([
            bottomCollection.topAnchor.constraint(equalTo: genrePicker.bottomAnchor, constant: 5),
            bottomCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 5),
            bottomCollection.heightAnchor.constraint(equalToConstant: 190),
            bottomCollection.widthAnchor.constraint(equalTo: scroll.widthAnchor),
            bottomCollection.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        ])
    }
    func setupPickerView() {
        self.scroll.addSubview(topPicker)
        topPicker.translatesAutoresizingMaskIntoConstraints = false
        topPicker.dataSource = self
        topPicker.delegate = self
        topPicker.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            topPicker.topAnchor.constraint(equalTo: scroll.topAnchor),
            topPicker.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 30),
            topPicker.heightAnchor.constraint(equalToConstant: 60),
            topPicker.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
    func setupGenrePickerView() {
        self.scroll.addSubview(genrePicker)
        genrePicker.translatesAutoresizingMaskIntoConstraints = false
        genrePicker.showsHorizontalScrollIndicator = false
        genrePicker.dataSource = self
        genrePicker.delegate = self
        genrePicker.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            genrePicker.topAnchor.constraint(equalTo: topCollection.bottomAnchor, constant: 45),
            genrePicker.leadingAnchor.constraint(equalTo: scroll.leadingAnchor),
            genrePicker.heightAnchor.constraint(equalToConstant: 60),
            genrePicker.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}
//MARK: - MovieViewProtocol
extension MoviesViewController: MovieViewProtocol {
    func showMoviesByGenre(movies: [Movie], with posters: [Int : UIImage]) {
        DispatchQueue.main.async {
            self.moviesByGenre.append(contentsOf: movies)
            self.postersByGenre.merge(posters) { image, _ in image }
            self.bottomCollection.reloadData()
        }
    }
    func showGenre(genre: [Genre]) {
        DispatchQueue.main.async {
            self.genres = genre
            self.genrePicker.reloadData()
        }
    }
    
    func show(movies: [Movie], with posters: [Int : UIImage]) {
        DispatchQueue.main.async {
            self.movies.append(contentsOf: movies)
            self.posters.merge(posters) { img, _ in img }
            self.topCollection.reloadData()
        }
    }
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return self.movies.count
        case 1:
            return TopTabs.allCases.count
        case 2:
            return self.moviesByGenre.count
        case 3:
            return genres.count
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifire, for: indexPath) as! TopCollectionViewCell
            let item = self.movies[indexPath.row]
            cell.movie = item
            cell.poster = self.posters[item.id ?? 0]
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopPickerViewCell.identifire, for: indexPath) as! TopPickerViewCell
            let item = TopTabs.allCases[indexPath.row]
            cell.tab = item
            
            cell.label.font = .systemFont(ofSize: 17, weight: .regular)
            cell.label.layer.cornerRadius = 0
            cell.label.backgroundColor = .clear
            cell.label.textColor = .gray
            cell.label.textAlignment = .center
            cell.label.clipsToBounds = true
            cell.label.layer.cornerRadius = 15
            cell.label.layer.borderWidth = 3
            cell.label.layer.borderColor = UIColor.gray.cgColor
            cell.label.backgroundColor = .white.withAlphaComponent(0.5)
            
            presenter?.haptic.tacticFeddback(style: .light)
            if item == selectedTab {
                cell.label.textColor = .white
                cell.label.layer.borderColor = UIColor.white.cgColor
            }
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifire, for: indexPath) as! TopCollectionViewCell
            let item = self.moviesByGenre[indexPath.row]
            cell.movie = item
            cell.poster = self.postersByGenre[item.id ?? 0]
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenrePickerCell.identifire, for: indexPath) as! GenrePickerCell
            let item = genres[indexPath.row]
            cell.tab = item
            
            cell.label.font = .systemFont(ofSize: 17, weight: .regular)
            cell.label.textAlignment = .center
            cell.label.clipsToBounds = true
            cell.label.layer.cornerRadius = 15
            cell.label.layer.borderWidth = 3
            cell.label.layer.borderColor = UIColor.gray.cgColor
            cell.label.textColor = .gray
            cell.label.backgroundColor = .white.withAlphaComponent(0.5)
            presenter?.haptic.tacticFeddback(style: .light)
            
            if item == selectedGenre {
                cell.label.textColor = .white
                cell.label.layer.borderColor = UIColor.white.cgColor
            }
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
        case 0:
            let item = self.movies[indexPath.row]
            guard let poster = posters[item.id ?? 0] else {
                return
            }
            presenter?.didMovieSelected(with: item.id ?? 0, poster: poster)
        case 1:
            let item = TopTabs.allCases[indexPath.row]
            self.selectedTab = item
            self.presenter?.viewControllerDidLoad(with: item)
            self.movies.removeAll()
            self.posters.removeAll()
            self.topPicker.reloadData()
            self.topCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
        case 2:
            let item = self.moviesByGenre[indexPath.row]
            guard let poster = postersByGenre[item.id ?? 0] else {
                return
            }
            presenter?.didMovieSelected(with: item.id ?? 0, poster: poster)
        case 3:
            let item = genres[indexPath.row]
            self.selectedGenre = item
            self.presenter?.viewControllerDidLoad(genre: item)
            self.moviesByGenre.removeAll()
            self.postersByGenre.removeAll()
            self.genrePicker.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.bottomCollection.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: true)
            }
        default:
            break
        }
    }
}
