//
//  Controller.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import Foundation

class Controller {
    private var viewModel = DataViewModel()
    
    func loadData(completion: @escaping (()->Void)) {
        guard let url = URL(string: "https://b1804a28-20f2-4c1d-b643-a8456583a821.mock.pstmn.io/latest/ios/products") else { return }
        viewModel.getData(url: url, completaion: completion)
    }
    
    func getTvCount() -> Int {
        return viewModel.getTvList().count
    }
    
    func getRecommendCount() -> Int {
        return viewModel.getRecommendList().count
    }
    
    func getNewEventCount() -> Int {
        return viewModel.getNewEventList().count
    }
    
    func getTv(index:Int) -> YSTv {
        return viewModel.getTvList()[index]
    }
    
    func getRecommend(index:Int) -> RecommendEvent {
        return viewModel.getRecommendList()[index]
    }
    
    func getNewEvent(index:Int) -> NewEvent {
        return viewModel.getNewEventList()[index]
    }
}
