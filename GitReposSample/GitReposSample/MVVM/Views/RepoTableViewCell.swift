//
//  RepoTableViewCell.swift
//  GitReposSample
//
//  Created by Blue Peak Systems on 9/7/21.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    var repository: Item? {
        didSet {
            if let avatarURLString = repository?.owner?.avatarURL?.urlEncoded, let url = URL(string: avatarURLString) {
                avatarImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "github"), options: .continueInBackground, context: nil)
            }else{
                avatarImageView.image = UIImage(named: "github")
            }
            ownerNameLabel.text = repository?.owner?.login
            repoNameLabel.text = repository?.name
            issuesLabel.text = "issues:"
            issuesCountLabel.text = "\(repository?.openIssuesCount ?? 0)"
            starsLabel.text = "stars:"
            starsCountLabel.text = "\(repository?.stargazersCount ?? 0)"
            languageLabel.text = "language:"
            languageNameLabel.text = "\(repository?.language ?? "")"
        }
    }
//    MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
//    MARK: - UI
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var ownerNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    private lazy var repoNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .light)
        return label
    }()
    private lazy var issuesLabel: UILabel = { return placeHolderLabel }()
    private lazy var issuesCountLabel: UILabel = { return countLabel }()
    private lazy var starsLabel: UILabel = { return placeHolderLabel }()
    private lazy var starsCountLabel: UILabel = { return countLabel }()
    private lazy var languageLabel: UILabel = { return placeHolderLabel }()
    private lazy var languageNameLabel: UILabel = { return countLabel }()
    private var placeHolderLabel: UILabel {
        let label = UILabel()
         label.textColor = .gray
         label.font = .systemFont(ofSize: 10, weight: .light)
         return label
    }
    private var countLabel: PaddedLabel {
        let label = PaddedLabel()
         label.textColor = .black
         label.font = .systemFont(ofSize: 10, weight: .regular)
        label.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        label.clipsToBounds = true
         return label
    }
    private func configureViews() {
        //        Avatar image
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(avatarImageView)
        avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.layer.cornerRadius = 25
        
        //        Owner name label
        ownerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(ownerNameLabel)
        ownerNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        ownerNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16).isActive = true
        ownerNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        //        Owner name label
        repoNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(repoNameLabel)
        repoNameLabel.topAnchor.constraint(equalTo: ownerNameLabel.bottomAnchor, constant: 4).isActive = true
        repoNameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 16).isActive = true
        repoNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 16).isActive = true
        
        //        Issues label
        issuesLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(issuesLabel)
        issuesLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16).isActive = true
        issuesLabel.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        
        //        Issues count label
        issuesCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(issuesCountLabel)
        issuesCountLabel.centerYAnchor.constraint(equalTo: issuesLabel.centerYAnchor).isActive = true
        issuesCountLabel.leftAnchor.constraint(equalTo: issuesLabel.rightAnchor, constant: 2).isActive = true
        issuesCountLabel.layer.cornerRadius = 8
        //        Stars label
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(starsLabel)
        starsLabel.centerYAnchor.constraint(equalTo: issuesLabel.centerYAnchor).isActive = true
        starsLabel.leftAnchor.constraint(equalTo: issuesCountLabel.rightAnchor, constant: 16).isActive = true

        //        Stars count label
        starsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(starsCountLabel)
        starsCountLabel.centerYAnchor.constraint(equalTo: starsLabel.centerYAnchor).isActive = true
        starsCountLabel.leftAnchor.constraint(equalTo: starsLabel.rightAnchor, constant: 2).isActive = true
        starsCountLabel.layer.cornerRadius = 8
        
        //        Language label
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(languageLabel)
        languageLabel.centerYAnchor.constraint(equalTo: issuesLabel.centerYAnchor).isActive = true
        languageLabel.leftAnchor.constraint(equalTo: starsCountLabel.rightAnchor, constant: 16).isActive = true

        //        Language name label
        languageNameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(languageNameLabel)
        languageNameLabel.centerYAnchor.constraint(equalTo: languageLabel.centerYAnchor).isActive = true
        languageNameLabel.leftAnchor.constraint(equalTo: languageLabel.rightAnchor, constant: 2).isActive = true
        languageNameLabel.layer.cornerRadius = 8
    }
}

class PaddedLabel: UILabel {
    var horizontalInset: CGFloat = 5.0
    var verticalInset: CGFloat = 3.0

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + 2*horizontalInset,
                      height: size.height + 2*verticalInset)
    }

    override var bounds: CGRect {
        didSet {
            // ensures this works within stack views if multi-line
            preferredMaxLayoutWidth = bounds.width - (2*horizontalInset)
        }
    }
}
