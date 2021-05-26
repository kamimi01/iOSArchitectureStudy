//
//  CustomView.swift
//  MVCSample
//
//  Created by Mika Urakawa on 2021/05/17.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    // Viewではなく、File's Ownerに対してCustomViewクラスを紐付ける
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    
    // defaultControllerClassをController型で定義し、Controller自信を入れる
    var defaultControllerClass: Controller.Type = Controller.self
    private var myController: Controller?
    
    var myModel: Model? {
        didSet {
            print("myModelに変更があった")
            // ControllerとModelの監視を開始する
            registerModel()
        }
    }
    
    deinit {
        myModel?.notificationCenter.removeObserver(self)
    }
    
    // 他の場所で再利用可能にする
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
        setSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNib()
        setSubViews()
    }
    
    private func loadNib() {
        // loadNibNamedは
        // nibを何度もインスタンス化するのであればパフォーマンス的には、UINibが良い
//        if let view = Bundle.main.loadNibNamed(String(describing: type(of: self)), owner: self)?.first as? UIView {
//            view.frame = self.bounds
//            self.addSubview(view)
//        }
        
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
    
    private func registerModel() {
        guard let model = myModel else {
            return
        }
        
        let controller = defaultControllerClass.init()
        controller.myModel = model
        myController = controller
        
        // descriptionは数値を文字列に変換
        label.text = model.count.description
        
        // タップ時のアクションをコードで実装する場合、addTargetを使用する（xibの場合はIBAction）
        minusButton.addTarget(controller, action: #selector(Controller.onMinusTapped), for: .touchUpInside)
        plusButton.addTarget(controller, action: #selector(Controller.onPlusTapped), for: .touchUpInside)
        
        print("modelが変わったので呼ばれた関数")
        
        /*
         NotificationCenterについて
         * name：通知を特定するためのタグ
         * object：通知を送ったオブジェクト（基本全てになるのでnilになる）
         * queue：ブロックを追加するオペレーションキュー（nilは通知を投稿するスレッドと同期して実行される）
         * using：通知を受け取ったときに実行されるブロック。ブロックは通知センターにコピーされ、オブザーバーの登録が解除されるまで保持される。ブロックは引数（notification）を一つとる。
         * userInfo：通知に関連するその他の情報
         */
        model.notificationCenter.addObserver(forName: .init(rawValue: "count"),
                                             object: nil,
                                             queue: nil,
                                             using:
                                                {[unowned self] notification in
                                                    if let count = notification.userInfo?["count"] as? Int {
                                                        self.label.text = count.description
                                                    }
                                                })
    }
}
