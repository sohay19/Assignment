//
//  SystemManager.swift
//  Assignment
//
//  Created by 소하 on 2023/02/17.
//

import UIKit


class SystemManager {
    static let shared = SystemManager()
    private init() { }
    
    private var loadingView:Loading?
    
    func openLoading(vc:UIViewController) {
        let identifier = String(describing: Loading.self)
        let nibs = Bundle.main.loadNibNamed(identifier, owner: vc, options: nil)
        guard let loadingView = nibs?.first as? Loading else { return }
        loadingView.frame = vc.view.frame
        loadingView.setUI()
        //
        self.loadingView = loadingView
        vc.view.addSubview(loadingView)
    }
    
    func closeLoading() {
        guard let loadingView = loadingView else { return }
        loadingView.removeFromSuperview()
    }
    
    func getDetailVC() -> UIViewController? {
        let board = UIStoryboard(name: "Detail", bundle: nil)
        guard let nextVC = board.instantiateViewController(withIdentifier: "Detail") as? DetailViewController else {
            return nil
        }
        return nextVC
    }
}
