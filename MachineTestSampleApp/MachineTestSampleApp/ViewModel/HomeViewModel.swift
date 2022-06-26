//
//  HomeViewModel.swift
//  MachineTestSampleApp
//
//  Created by ashik_h on 24/06/22.
//

import Foundation

class HomeViewModel {
    
    private var apiService: ApiService!
    
    private(set) var homeData: HomeDataModel!
    
    var bindHomeViewModelToViewController: (() -> ()) = {}
    
    init() {
        self.apiService = ApiService()
    }
    
    func fetchHomeData(completion: @escaping () -> Void) {
        self.apiService.getHomeDataApi(completion: { (homeData) in
            self.homeData = homeData
            completion()
        })
    }
}
