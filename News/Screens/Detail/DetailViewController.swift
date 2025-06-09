//
//  DetailViewController.swift
//  News
//
//  Created by Muhammed Yılmaz on 4.06.2025.
//

import UIKit
import SnapKit
import Kingfisher

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: DetailViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let articleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "placeholder")
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - Inıt
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureView()
        configureLabels()
    }
}

// MARK: - Private Methods
private extension DetailViewController {
    func configureView() {
        title = "News Detail"
        view.backgroundColor = .systemBackground
        addViews()
        configureLayout()
        articleImageView.kf.setImage(with: URL(string: viewModel.article?.urlToImage ?? ""))
    }
    func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(articleImageView)
        view.addSubview(descriptionLabel)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        articleImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(200)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(articleImageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    func configureLabels() {
        titleLabel.text = viewModel.article?.title
        descriptionLabel.text = viewModel.article?.description
    }
}
