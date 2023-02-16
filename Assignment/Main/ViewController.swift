//
//  ViewController.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableMain: UITableView!
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var imgLogo: UIImageView!
    
    var controller = Controller()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableMain.delegate = self
        tableMain.dataSource = self
        initUI()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SystemManager.shared.openLoading(vc: self)
        // 데이터 호출
        controller.loadData {
            DispatchQueue.main.async { [self] in
                tableMain.reloadData()
                guard let headerView = tableMain.tableHeaderView as? MainHeaderView else { return }
                headerView.collectionTv.reloadData()
                SystemManager.shared.closeLoading()
            }
        }
    }
    // UI 초기화
    private func initUI() {
        line.backgroundColor = .lightGray.withAlphaComponent(0.3)
        tableMain.backgroundColor = .white
        tableMain.sectionHeaderHeight = 50
        tableMain.sectionFooterHeight = 30
        tableMain.separatorInsetReference = .fromCellEdges
        tableMain.showsVerticalScrollIndicator = false
        // UI 세팅
        imgLogo.image = UIImage(named: "logo")
        searchField.placeholder = "피부시술을 검색해 보세요. :)"
        searchField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: searchField.frame.size.height-1, width: searchField.frame.width, height: 2)
        border.backgroundColor = UIColor.defaultPink.cgColor
        searchField.layer.addSublayer(border)
        // 테이블 헤더 추가
        let identifier = String(describing: MainHeaderView.self)
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        guard let headerView = nibs?.first as? MainHeaderView else { return }
        headerView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: tableMain.frame.width, height: 180))
        headerView.setUI()
        headerView.setDelegate(dataSource: self, delegate: self)
        tableMain.tableHeaderView = headerView
    }
    // cell 등록
    private func registerCell() {
        tableMain.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
    }
}

