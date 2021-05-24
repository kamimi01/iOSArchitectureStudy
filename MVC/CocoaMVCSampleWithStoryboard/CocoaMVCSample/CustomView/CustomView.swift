//
//  CustomView.swift
//  CocoaMVCSample
//
//  Created by Mika Urakawa on 2021/05/24.
//

import Foundation
import UIKit

class CustomView: UIView {
    // ViewはModelを一切知らない
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setSubView()
        print("どうして")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setSubView()
    }
    
    private func loadNib() {
        if let view = UINib(nibName: String(describing: type(of: self)), bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    private func setSubView() {
        label.text = "0"
        plusButton.setTitle("+1", for: .normal)
        minusButton.setTitle("-1", for: .normal)
    }
}
