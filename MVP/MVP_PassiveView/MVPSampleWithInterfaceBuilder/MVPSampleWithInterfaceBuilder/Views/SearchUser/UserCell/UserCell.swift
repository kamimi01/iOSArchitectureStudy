//
//  UserCell.swift
//  MVPSampleWithInterfaceBuilder
//
//  Created by Mika Urakawa on 2021/06/06.
//

import UIKit

final class UserCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var task: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
        task = nil
        imageView?.image = nil
    }

    func configure(user: User) {
        // GitHubのユーザー検索APIで取得したアバターのURLを表示する
        task = {
            let url = user.avatarURL
            let request = URLRequest(url: NSURL(string:url)! as URL)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let imageData = data else {
                    return
                }

                DispatchQueue.global().async { [weak self] in
                    guard let image = UIImage(data: imageData) else {
                        return
                    }

                    DispatchQueue.main.async {
                        self?.iconImageView?.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
            task.resume()
            return task
        }()

        nameLabel.text = user.login
    }
}
