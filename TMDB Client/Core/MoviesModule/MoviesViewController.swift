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
           return "Tranding"
        case .topRated:
           return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}


protocol MovieViewProtocol: AnyObject {
    func show(movies: [Movie], with posters: [Int : UIImage])
}

class MoviesViewController: UIViewController {
    //MARK: - property
    var presenter: MoviePresenterProtocol?
    private var movies: [Movie] = []
    private var posters: [Int : UIImage] = [:]
    private var selectedTab: TopTabs = .trending
    private lazy var scroll: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    private lazy var searchController: UISearchController = {
        let sc = UISearchController()
        return sc
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
    private lazy var topPicker: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = .init(width: UIScreen.main.bounds.width / 4, height: 50)
        flow.scrollDirection = .horizontal
        let cell = UICollectionView(frame: .zero, collectionViewLayout: flow)
        cell.register(TopPickerViewCell.self, forCellWithReuseIdentifier: TopPickerViewCell.identifire)
        cell.tag = 1
        return cell
    }()
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.customBackground
        self.navigationItem.title = "Movies"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = searchController
        presenter?.viewControllerDidLoad(with: selectedTab)
        setupLayout()
    }
}
//MARK: - UI layout
private extension MoviesViewController {
    func setupLayout() {
       // DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.setupScrollView()
            self.setupPickerView()
            self.setupTopCollectionCell()
       // }
    }
    func setupScrollView() {
        let margins = self.view.layoutMarginsGuide
        self.view.addSubview(scroll)
        scroll.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: margins.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }
    func setupTopCollectionCell() {
        self.view.addSubview(topCollection)
        topCollection.translatesAutoresizingMaskIntoConstraints = false
        topCollection.backgroundColor = UIColor.customBackground
        topCollection.dataSource = self
        topCollection.delegate = self
        
        NSLayoutConstraint.activate([
            topCollection.topAnchor.constraint(equalTo: topPicker.bottomAnchor, constant: 5),
            topCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 5),
            topCollection.trailingAnchor.constraint(equalTo: scroll.trailingAnchor, constant: -5),
            topCollection.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    func setupPickerView() {
        scroll.addSubview(topPicker)
        topPicker.translatesAutoresizingMaskIntoConstraints = false
        topPicker.dataSource = self
        topPicker.delegate = self
        topPicker.backgroundColor = UIColor.customBackground
        
        NSLayoutConstraint.activate([
            topPicker.topAnchor.constraint(equalTo: scroll.topAnchor),
            topPicker.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 50),
            topPicker.heightAnchor.constraint(equalToConstant: 60),
            topPicker.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        ])
    }
}
//MARK: - MovieViewProtocol
extension MoviesViewController: MovieViewProtocol {
    func show(movies: [Movie], with posters: [Int : UIImage]) {
        DispatchQueue.main.async {
            self.movies.append(contentsOf: movies)
            self.posters.merge(posters) { img, _ in img }
            self.topCollection.reloadData()
        }
    }
}
//MARK: -
extension MoviesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return self.movies.count
        case 1:
            return TopTabs.allCases.count
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
            cell.label.textAlignment = .left
            cell.label.clipsToBounds = false
            cell.label.layer.cornerRadius = 0
            cell.label.backgroundColor = .clear
            
            if item == selectedTab {
                cell.label.font = .systemFont(ofSize: 20, weight: .bold)
                cell.label.textAlignment = .center
                cell.label.clipsToBounds = true
                cell.label.layer.cornerRadius = 15
                cell.label.backgroundColor = .white.withAlphaComponent(0.5)
                
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
        case 1:
            let item = TopTabs.allCases[indexPath.row]
            self.selectedTab = item
            self.presenter?.viewControllerDidLoad(with: item)
            self.movies.removeAll()
            self.posters.removeAll()
            self.topPicker.reloadData()
        default:
            break
        }
    }
}
