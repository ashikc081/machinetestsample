//
//  ViewController.swift
//  MachineTestSampleApp
//
//  Created by ashik_h on 24/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    private var homeViewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        getHomeDataForUi()
    }

    func getHomeDataForUi() {
        self.homeViewModel = HomeViewModel()
        homeViewModel.fetchHomeData {
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        }
    }
    
    func setupTableView() {
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.register(UINib(nibName: "CategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CategoryTableViewCell")
        self.homeTableView.register(UINib(nibName: "BannerTableViewCell", bundle: nil), forCellReuseIdentifier: "BannerTableViewCell")
        self.homeTableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductTableViewCell")
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = homeViewModel.homeData, let hData = data.homeData {
            return hData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let data = homeViewModel.homeData, let _ = data.homeData {
            return getTableViewCell(for: tableView, at: indexPath)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let data = homeViewModel.homeData, let _ = data.homeData {
            return getTableViewCellHeights(for: indexPath.row)
        }
        return 0
    }
    
    func getTableViewCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let homeDataType = HomeDataType(rawValue: homeViewModel.homeData.homeData?[indexPath.row].type ?? "")
        switch homeDataType {
        case .category:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
            cell.setCategoriesData(data: homeViewModel.homeData.homeData?[indexPath.row].itemDetails ?? [])
            return cell
        case .banners:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BannerTableViewCell", for: indexPath) as! BannerTableViewCell
            cell.setupBannersData(data: homeViewModel.homeData.homeData?[indexPath.row].itemDetails ?? [])
            return cell
        case .products:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
            cell.setupProductsData(data: homeViewModel.homeData.homeData?[indexPath.row].itemDetails ?? [])
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
    func getTableViewCellHeights(for row: Int) -> CGFloat {
        let homeDataType = HomeDataType(rawValue: homeViewModel.homeData.homeData?[row].type ?? "")
        switch homeDataType {
        case .category:
            return 107
        case .banners:
            return 197
        case .products:
            return 301
        case .none:
            return 0
        }
    }
}

enum HomeDataType: String {
    case category
    case banners
    case products
}

