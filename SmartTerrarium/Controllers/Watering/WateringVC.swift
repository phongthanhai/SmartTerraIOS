//
//  WateringVC.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 11/11/2024.
//

import Foundation
import UIKit

class WateringVC: UIViewController{
    
    // MARK: VIEW
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    let cardView            = UIView()
    let cardWateringButton  = WateringButton()
    let tableView           = UITableView()
    var waterSchedules: [WaterSchedule] = []
    
    let healthCard          = HealthCard()
    let heading             = CustomLabel1(textAlignment: .left, fontSize: 40, textWeight: .bold, text: "Watering")
    
    let discriptionLbl      = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .semibold, text: "Watering System")
    let detailsLbl          = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .regular, text: "Keep your terrarium healthy using manual watering, automatic water scheduling and more!")
    
    let manualWateringLbl   = CustomLabel1(textAlignment: .left, fontSize: 24 , textWeight: .bold, text: "Manual Watering")
    
    let autoWateringLbl     = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .bold, text: "Automatic Watering")
    
    struct Schedule {
        let no: Int
        let day: Date
        let time: Date
    }
    
    private var schedules: [Schedule] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        configScrollView()
        configLabels()
        configCardView()
        configButton()
        configTable()
        
    }
    
    private func configTable(){
        self.waterSchedules = fetchedWaterSchedules
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Register cell:
        tableView.register(WaterCell.self
                           , forCellReuseIdentifier:WaterCell.tvcell )
        contentView.addSubview(tableView)
        
        /*
         Task{
             do {
                 //call API xxx
                 
                 
             }
         }
         */
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: autoWateringLbl.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 800 + CGFloat(waterSchedules.count * 100))
        ])
    }
    
    private func configVC(){
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        contentView.addSubViews(heading, cardView, manualWateringLbl, discriptionLbl, detailsLbl, cardWateringButton, autoWateringLbl)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    private func configScrollView() {
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
            
            manualWateringLbl.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            manualWateringLbl.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            manualWateringLbl.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            manualWateringLbl.heightAnchor.constraint(equalToConstant: 22),
            
            autoWateringLbl.topAnchor.constraint(equalTo: cardWateringButton.bottomAnchor, constant: 20),
            autoWateringLbl.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            autoWateringLbl.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            autoWateringLbl.heightAnchor.constraint(equalToConstant: 22)
            
            
        ])
    }
    
    private func configCardView(){
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(healthCard)
        
        healthCard.setImage(UIImage(named: "watering_card"))
        healthCard.text.numberOfLines = 1
        healthCard.setLbl(label: "Need water?")
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: detailsLbl.bottomAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: detailsLbl.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: detailsLbl.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            healthCard.topAnchor.constraint(equalTo: cardView.topAnchor),
            healthCard.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            healthCard.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            healthCard.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    private func configButton(){
        cardWateringButton.setImage(UIImage(named: "watering_button"))
        cardWateringButton.setLbl(label: "Press and hold to water!")
        
        NSLayoutConstraint.activate([
            cardWateringButton.topAnchor.constraint(equalTo: manualWateringLbl.bottomAnchor, constant: 20),
            cardWateringButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cardWateringButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            cardWateringButton.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

   
}

extension WateringVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        waterSchedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WaterCell.tvcell, for: indexPath) as! WaterCell
        
        let cellItem = waterSchedules[indexPath.row]
        cell.config(with: cellItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completion) in
                guard let self = self else { return }
                
                // Get the schedule to delete
                let scheduleToDelete = self.waterSchedules[indexPath.row]
                
                // Call API to delete from database
                /*
                 Task {
                     do {
                         try await self.deleteScheduleFromDatabase(schedule: scheduleToDelete)
                         
                         // If API call successful, update UI on main thread
                         await MainActor.run {
                             // Remove from local array
                             self.waterSchedules.remove(at: indexPath.row)
                             
                             // Delete row with animation
                             tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)],
                                               with: .fade)
                         }
                         completion(true)
                     } catch {
                         // Handle error
                         print("Failed to delete schedule: \(error)")
                         completion(false)
                         
                         // Show error alert to user
                         await MainActor.run {
                             self.showErrorAlert(message: "Failed to delete schedule. Please try again.")
                         }
                     }
                 }
                 */
                
            }
            
            deleteAction.backgroundColor = .systemRed
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
}

