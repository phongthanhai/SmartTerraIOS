//
//  FanVC.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 27/12/2024.
//

import Foundation
import UIKit

class FanVC: UIViewController{
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    let cardView            = UIView()
    let fanCard             = HealthCard()
    var fanTimer: Timer?

    let heading             = CustomLabel1(textAlignment: .left, fontSize: 40, textWeight: .bold, text: "Fan Control")

    let discriptionLbl      = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .semibold, text: "Fan System")
    let detailsLbl          = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .regular, text: "Keep everything ventilated!")
    
    let switchLbl           = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .regular, text: "Fan is OFF")
    
    let fanSwitch           = UISwitch()

    private func configVC(){
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        contentView.addSubViews(heading, cardView, discriptionLbl, detailsLbl, fanSwitch,switchLbl)
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
            
            switchLbl.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 16),
            switchLbl.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            switchLbl.widthAnchor.constraint(equalToConstant: 120),
            switchLbl.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func configCardView(){
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(fanCard)
        
        fanCard.setImage(UIImage(named: "fan_card"))
        fanCard.text.numberOfLines = 1
        fanCard.setLbl(label: "I am your fan!")
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: detailsLbl.bottomAnchor, constant: 16),
            cardView.leadingAnchor.constraint(equalTo: detailsLbl.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: detailsLbl.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
            fanCard.topAnchor.constraint(equalTo: cardView.topAnchor),
            fanCard.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            fanCard.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            fanCard.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
    
    private func configSwitch(){
        fanSwitch.translatesAutoresizingMaskIntoConstraints = false
        fanSwitch.isOn = false
        fanSwitch.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            fanSwitch.topAnchor.constraint(equalTo: switchLbl.topAnchor),
            fanSwitch.leadingAnchor.constraint(equalTo: switchLbl.trailingAnchor, constant: 20 ),
            fanSwitch.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            fanSwitch.heightAnchor.constraint(equalTo: switchLbl.heightAnchor)
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        configScrollView()
        configLabels()
        configCardView()
        configSwitch()
        
    }
    
    

    @objc func switchValueChanged(_ sender: UISwitch) {
        let fanState = sender.isOn
        switchLbl.text = fanState ? "Fan is ON" : "Fan is OFF"

        // Reset timer
        fanTimer?.invalidate()

        if fanState {
            print("Fan turned ON")
            // start timer, to then turn the fan of after 60 seconds.
            fanTimer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(turnOffFan), userInfo: nil, repeats: false)

            // Call API to send fan on.
            let fanRequest = FanRequest(Id: 1, fan: true, duration: 60.0)
            Task {
                do {
                    let fanResponse = try await Networking.shared.postToggleFan(fanRequest)
                    print("Fan ON API Response: \(fanResponse)")
                } catch {
                    print("Error calling API: \(error)")
                }
            }
        } else {
            print("Fan turned OFF")
            // Call API to send fan off.
            let fanRequest = FanRequest(Id: 2, fan: false, duration: 0.0)
            Task {
                do {
                    let fanResponse = try await Networking.shared.postToggleFan(fanRequest)
                    print("Fan OFF API Response: \(fanResponse)")
                } catch {
                    print("Error calling API: \(error)")
                }
            }
        }
    }

    @objc func turnOffFan() {
        print("Timer expired. Turning off the fan.")
        fanSwitch.setOn(false, animated: true)
        switchLbl.text = "Fan is OFF"

        // Call API to send fan: false
        let fanRequest = FanRequest(Id: 1, fan: false, duration: 0.0)
        Task {
            do {
                let fanResponse = try await Networking.shared.postToggleFan(fanRequest)
                print("Fan OFF API Response after timer: \(fanResponse)")
            } catch {
                print("Error calling API after timer: \(error)")
            }
        }
    }

}

    
