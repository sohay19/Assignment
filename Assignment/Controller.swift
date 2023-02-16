//
//  Controller.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import Foundation

class Controller {
    private var viewModel = DataViewModel()
    
    /// 데이터 로드 요청
    func loadData(completion: @escaping (()->Void)) {
        guard let url = URL(string: "https://b1804a28-20f2-4c1d-b643-a8456583a821.mock.pstmn.io/latest/ios/products") else { return }
        viewModel.getData(url: url, completaion: completion)
    }
    // 각 데이터 카운트
    func getTvCount() -> Int {
        return viewModel.getTvList().count
    }
    func getRecommendCount() -> Int {
        return viewModel.getRecommendList().count
    }
    func getNewEventCount() -> Int {
        return viewModel.getNewEventList().count
    }
    // 각 인덱스에 해당하는 데이터 반환
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
