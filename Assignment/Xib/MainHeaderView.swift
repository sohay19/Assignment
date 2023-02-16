//
//  MainHeaderView.swift
//  Assignment
//
//  Created by 소하 on 2023/02/16.
//

import UIKit

class MainHeaderView: UIView {
    @IBOutlet weak var labelTv: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    @IBOutlet weak var collectionTv: UICollectionView!
    @IBOutlet weak var line: UIView!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        initUI()
        registerCell()
    }
    
    private func initUI() {
        labelTv.font = .systemFont(ofSize: 15, weight: .semibold)
        labelTv.textColor = .black
        btnMore.titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        btnMore.tintColor = .lightGray
        collectionTv.showsHorizontalScrollIndicator = false
        line.backgroundColor = .lightGray.withAlphaComponent(0.3)
    }
    
    private func registerCell() {
        collectionTv.register(UINib(nibName: "TVCell", bundle: nil), forCellWithReuseIdentifier: "TVCell")
    }
    
    func setDelegate(dataSource:UICollectionViewDataSource, delegate:UICollectionViewDelegate) {
        collectionTv.dataSource = dataSource
        collectionTv.delegate = delegate
    }
}
