//
//  NoDataView.swift
//  PopularMovies
//
//  Created by Vivatum on 07/06/2020.
//  Copyright © 2020 Włodzimierz Woźniak. All rights reserved.
//

import UIKit

final class NoDataView: UIView {

    @IBOutlet var noDataView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    public var message: NoDataMessage = .noMessage {
        didSet {
            DispatchQueue.main.async {
                self.titleLabel.text = self.message.message
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil)
        addSubview(noDataView)
        noDataView.frame = self.bounds
        noDataView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        noDataView.backgroundColor = AppColor.mainBackground
        self.titleLabel.text = NoDataMessage.noMessage.message
        self.titleLabel.textColor = AppColor.noDataMessage
        self.titleLabel.font = AppFont.noDataMessage
    }
}
