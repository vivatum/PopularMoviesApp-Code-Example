//
//  TitleHeaderView.swift
//  PopularMovies
//
//  Created by Vivatum on 09/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

protocol HeaderViewTapDelegate: class {
    func headerViewTapped()
}

final class TitleHeaderView: UIView {
    @IBOutlet var titleHeaderView: UIView!
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var tapView: UIView!
    
    weak var delegate: HeaderViewTapDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        Bundle.main.loadNibNamed("TitleHeaderView", owner: self, options: nil)
        addSubview(titleHeaderView)
        titleHeaderView.frame = self.bounds
        titleHeaderView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        titleHeaderView.backgroundColor = AppColor.mainBackground
        setupView()
    }
    
    private func setupView() {
        titleHeaderView.backgroundColor = AppColor.mainBackground
        tapView.backgroundColor = .clear
        if let titleImage = UIImage(named: "pic_header_title") {
            self.titleImageView.image = titleImage
        }
        setupTapGesture()
    }
    
    
    // MARK: - TapGesture
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapHandler))
        tapView.addGestureRecognizer(tap)
    }
    
    @objc func tapHandler() {
        self.delegate?.headerViewTapped()
    }
}
