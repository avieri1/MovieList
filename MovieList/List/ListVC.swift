//
//  ListVC.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import UIKit

protocol ListViewInterface {
    var presenter: ListPresenterInterface? { get set }
    var listMovie: ListMovie? { get }
    var id: Int? { get set }
    func setupView()
    func showView(with result: ListMovie)

}

class ListVC: UIViewController, ListViewInterface, UITableViewDelegate, UITableViewDataSource {
    
    var id: Int?
    var listMovie: ListMovie?
    var presenter: ListPresenterInterface?
    var currentPage: Int?
    var ListStored: [[Any]] = []
    
    func setupView() {
        tableView.register(UINib(nibName: ListCell.identifier, bundle: nil), forCellReuseIdentifier: ListCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView()
        
        presenter?.fetchDatas(with: id!, with: "en-US", with: 1, with: "popularity.desc")
    }
    
    func showView(with result: ListMovie) {
        DispatchQueue.main.async {
            self.listMovie = result
            for i in result.results! {
                self.ListStored.append([i.title ?? "",i.popularity ?? 0, i.id ?? 0])
            }
            
            self.tableView.reloadData()
        }
        
    }
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPage = 1
        presenter?.notifyViewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  ListStored.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        
        if indexPath.item == 0 {
            cell.primaryLbl.text = "Title"
            
            cell.secondaryLbl.text = "Popularity Rating"
        }
        else{
            cell.primaryLbl.text = ListStored[indexPath.item - 1][0] as? String
            
            cell.secondaryLbl.text = "\(ListStored[indexPath.item - 1][1] as? Double ?? 0)"
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.item == ListStored.count - 6 {
            currentPage = (currentPage ?? 1) + 1
            presenter?.fetchDatas(with: id!, with: "en-US", with: currentPage!, with: "popularity.desc")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item != 0 {
            presenter?.viewPushToDetail(with: (ListStored[indexPath.item - 1][2] as? Int)!)
        }
       
    }

}
