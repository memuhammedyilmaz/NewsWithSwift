//
//  SettingsVC.swift
//  News
//
//  Created by Muhammed Yılmaz on 28.05.2025.
//

import UIKit
import SnapKit
import StoreKit
import SafariServices

final class SettingsViewController: UIViewController {

    //MARK: - Properties
    
    private let viewModel : SettingsViewModel
    private let themeKey = "selectedTheme"
    
    private lazy var TableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let appVerisonLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .center
        label.text = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "?"
        return label
    }()
    
    init(viewModel: SettingsViewModel = . init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      configureView()
    }

}

//MARK: - Objective Methods

@objc private extension SettingsViewController {
    func didChangeTheme(_ sender: UISegmentedControl) {
        updateThemeMode(to: sender.selectedSegmentIndex)
    }
    
    func didToggleNotification(_ sender: UISwitch) {
        viewModel.updateNotificationStatus(isOn: sender.isOn)
    }
}

//MARK: - Private Methods
private extension SettingsViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        addViews()
        configureLayout()
    }
    
    func addViews() {
        view.addSubview(TableView)
        view.addSubview(appVerisonLabel)
    }
    
    func configureLayout() {
        TableView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        appVerisonLabel.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.centerX.equalToSuperview()
        }
    }
    func updateThemeMode(to mode: Int) {
        UserDefaults.standard.set(mode, forKey: themeKey)
        
        switch mode {
        case 1:
            view.window?.overrideUserInterfaceStyle = .light
            case 2:
            view.window?.overrideUserInterfaceStyle = .dark
        default:
            view.window?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    func didSelect(item: SettingsItem) {
        switch item.type {
        case .rateApp: promptReview()
        case .privacyPolicy, .termOfUse: openUrl("https://muhammedyilmaz.co")
        default: break
        }
    }
    
    func promptReview() {
        if let scene = view.window?.windowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    func openUrl(_ url: String) {
        guard let urlToOpen = URL(string: url) else {return}
        let safariVC = SFSafariViewController(url: urlToOpen)
        safariVC.modalPresentationStyle = .overFullScreen
        present(safariVC, animated: true)
    }
}

//MARK: - UITableViewDelegate

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = viewModel.sections[indexPath.section].items[indexPath.row]
        didSelect(item: item)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let section = viewModel.sections[indexPath.section]
        let item = section.items[indexPath.row]
        
        cell.tintColor = .label
        cell.textLabel?.text = item.title
        cell.textLabel?.textAlignment = .natural
        cell.textLabel?.textColor = .label
        cell.imageView?.image = UIImage(systemName: item.iconName)
        
        switch item.type {
        case .theme:
            let segmentedControl = UISegmentedControl(items: ["Auto", "Light", "Dark"])
            segmentedControl.selectedSegmentIndex = viewModel.fetchThemeMode()
            segmentedControl.addTarget(self, action: #selector(didChangeTheme(_:)), for: .valueChanged)
            cell.accessoryView = segmentedControl
        case .notification:
            let switcher = UISwitch()
            viewModel.fetchNotificationStatus { switcher.isOn = $0 }
            switcher.addTarget(self, action: #selector(didToggleNotification(_:)), for: .valueChanged)
            cell.accessoryView = switcher
        case .rateApp, .privacyPolicy, .termOfUse:
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
}
