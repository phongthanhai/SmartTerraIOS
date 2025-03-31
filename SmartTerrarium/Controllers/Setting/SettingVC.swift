

import Foundation
import UIKit

class SettingVC: UIViewController{
    let scrollView          = UIScrollView()
    let contentView         = UIView()

    let heading             = CustomLabel1(textAlignment: .left, fontSize: 40, textWeight: .bold, text: "System Setting")

    let discriptionLbl      = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .semibold, text: "Customize System Settings")
    let detailsLbl          = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .regular, text: "Coming Soon...")
    

    private func configVC(){
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        contentView.addSubViews(heading, discriptionLbl, detailsLbl)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func configScrollView(){
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(to: view)
        scrollView.contentInsetAdjustmentBehavior = .never
        
        contentView.pinToEdges(to: scrollView)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1400)
        ])
    }

    private func configLabels(){
        heading.translatesAutoresizingMaskIntoConstraints = false
        detailsLbl.numberOfLines    = 0
        detailsLbl.textColor        = UIColor.gray
        
        NSLayoutConstraint.activate([
            heading.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            heading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heading.heightAnchor.constraint(equalToConstant: 40),
            
            discriptionLbl.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 16),
            discriptionLbl.leadingAnchor.constraint(equalTo: heading.leadingAnchor),
            discriptionLbl.trailingAnchor.constraint(equalTo: heading.trailingAnchor),
            discriptionLbl.heightAnchor.constraint(equalToConstant: 24),
            
            detailsLbl.topAnchor.constraint(equalTo: discriptionLbl.bottomAnchor, constant: 16),
            detailsLbl.leadingAnchor.constraint(equalTo: heading.leadingAnchor),
            detailsLbl.trailingAnchor.constraint(equalTo: heading.trailingAnchor),
        ])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        configScrollView()
        configLabels()
        
    }

}

    
