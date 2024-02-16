//
//  HomeVC.swift
//  MovieList
//
//  Created by aldo on 15/02/24.
//

import UIKit

protocol HomeViewInterface {
    var presenter: HomePresenterInterface? { get set }
    var result: Genre? { get }
    func setupView()
    func showView(with result: Genre)

}

class HomeVC: UIViewController, HomeViewInterface, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var result: Genre?
    var presenter: HomePresenterInterface?
    
    func showView(with result: Genre) {
        DispatchQueue.main.async {
            self.result = result
            self.tableView.reloadData()
        }
        
    }
 
    func setupView() {
        tableView.register(UINib(nibName: HomeCell.identifier, bundle: nil), forCellReuseIdentifier: HomeCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter?.fetchDatas(with: "en")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result?.genres?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as! HomeCell
        
        cell.labelTxt.text = result?.genres?[indexPath.item].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(result?.genres?[indexPath.item].id ?? "")
        presenter?.viewPushToList(with: result?.genres?[indexPath.item].id ?? 0)
    }

}
