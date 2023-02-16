//
//  ViewController.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableMain: UITableView!
    @IBOutlet weak var line: UIView!
    
    private var isRefresh = false
    var controller = Controller()

    override func viewDidLoad() {
        super.viewDidLoad()
        //
        tableMain.dataSource = self
        tableMain.delegate = self
        //
        controller.loadData {
            DispatchQueue.main.async { [self] in
                tableMain.reloadData()
                guard let headerView = tableMain.tableHeaderView as? MainHeaderView else { return }
                headerView.collectionTv.reloadData()
                isRefresh = true
                beginAppearanceTransition(false, animated: false)
            }
        }
        initUI()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        if isRefresh {
            endAppearanceTransition()
            isRefresh = false
        }
    }
        
    private func initUI() {
        line.backgroundColor = .lightGray.withAlphaComponent(0.3)
        //
        tableMain.backgroundColor = .white
        tableMain.sectionHeaderHeight = 50
        tableMain.sectionFooterHeight = 30
        tableMain.separatorInsetReference = .fromCellEdges
        tableMain.showsVerticalScrollIndicator = false
        //
        let identifier = String(describing: MainHeaderView.self)
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)
        guard let headerView = nibs?.first as? MainHeaderView else { return }
        headerView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: tableMain.frame.width, height: 180))
        headerView.setUI()
        headerView.setDelegate(dataSource: self, delegate: self)
        tableMain.tableHeaderView = headerView
    }
    
    private func registerCell() {
        tableMain.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
    }
}

