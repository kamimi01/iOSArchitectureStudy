//
//  View.swift
//  CocoaMVCSample
//
//  Created by Mika Urakawa on 2021/05/25.
//  Copyright © 2021 史翔新. All rights reserved.
//

import Foundation
import UIKit

class CustomView: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
    }
    
    private func loadNib() {
        print("viewの中身:", UINib(nibName: String(describing: type(of: self)), bundle: Bundle.main).instantiate(withOwner: self, options: nil))
        
        if let view = UINib(nibName: String(describing: type(of: self)), bundle: Bundle.main).instantiate(withOwner: self, options: nil).first as? UIView {
            view.frame = self.bounds
            self.addSubview(view)
        }
    }
    
    private func setSubViews() {
        label.text = "0"
        plusButton.setTitle("+1", for: .normal)
        minusButton.setTitle("-1", for: .normal)
    }
    
}
