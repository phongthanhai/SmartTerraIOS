//
//  TerrariumDashboardVC.swift
//  SmartTerrarium
//
//  Created by Than Hai Phong on 09/11/2024.
//

import Foundation
import UIKit
import DGCharts

class TerrariumDashboardVC: UIViewController {
    
    let scrollView      = UIScrollView()
    let contentView     = UIView()
    let cardView        = UIView()
    let heading         = CustomLabel1(textAlignment: .left, fontSize: 40, textWeight: .bold, text: "Dashboard")
    
    let healthCard      = HealthCard()
    let temperatureCard = TemperatureCard()
    let humidityCard    = HumidityCard()
    let waterCard       = WaterCard()
    let amountWaterCard = AmountWaterCard()
    var isMetricsLoaded: Bool = false
    var sensorDatas: [SensorDataResponse] = []
    let statusLabel     = StatusManager.shared.statusLabel
    
    let discriptionLbl      = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .semibold, text: "Main Dashboard")
    let detailsLbl          = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .regular, text: "Monitor the system using the provided metrics")
    
    let overallLbl          = CustomLabel1(textAlignment: .left, fontSize: 24, textWeight: .semibold, text: "Health & Metrics")
    
    
    
    //Chart setup
    private let temperatureChart = LineChartView()
    private let humidityChart = LineChartView()
    private let moistureChart = LineChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()
        configScrollView()
        configHeading()
        configSubHeading()
        configDashboard()
        configCardView()
        configCharts()
        
        if(!isMetricsLoaded){
            Task{
                do{
                    sensorDatas = try await Networking.shared.getSensorData("1")
                    updateMetrics(with: sensorDatas)
                    updateCharts(with: sensorDatas)
                }catch{
                    print("Error calling GET sensordata API: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Task{
            do{
                sensorDatas = try await Networking.shared.getSensorData("1")
                updateMetrics(with: sensorDatas)
            }catch{
                print("Error calling GET sensordata API: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateMetrics(with sensorDatas: [SensorDataResponse]){
        if let currentMetrics: SensorDataResponse = sensorDatas.last{
            if let temperature = currentMetrics.temperature{
                temperatureCard.setTemperature("\(temperature)°C")
            }
            if let humidity    = currentMetrics.humidity{
                humidityCard.setHumidity("\(humidity)%")
            }
            
            if let moisture    = currentMetrics.moisture{
                waterCard.setMoisture("\(moisture)%")
            }
        }
    }
    
    private func configScrollView() {
       
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(to: view)
        scrollView.contentInsetAdjustmentBehavior = .never
        
        contentView.pinToEdges(to: scrollView)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 2000)
        ])
    }
    
    private func startAmountWaterCardFillAnimation(){
        amountWaterCard.startFillAnimation()
    }
    
    private func stopAmountWaterCardFillAnimation(){
        amountWaterCard.stopFillAnimation()
    }
    
    private func configVC(){
        
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        contentView.addSubViews(cardView,heading,discriptionLbl,detailsLbl,overallLbl,statusLabel)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    private func configHeading(){
        heading.translatesAutoresizingMaskIntoConstraints = false
        detailsLbl.numberOfLines = 0
        detailsLbl.textColor = UIColor.gray
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heading.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 20),
            heading.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heading.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heading.heightAnchor.constraint(equalToConstant: 40),
            
            discriptionLbl.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 16),
            discriptionLbl.leadingAnchor.constraint(equalTo: heading.leadingAnchor),
            discriptionLbl.trailingAnchor.constraint(equalTo: heading.trailingAnchor),
            discriptionLbl.heightAnchor.constraint(equalToConstant: 24),
            
            detailsLbl.topAnchor.constraint(equalTo: discriptionLbl.bottomAnchor, constant: 16),
            detailsLbl.leadingAnchor.constraint(equalTo: heading.leadingAnchor),
            detailsLbl.trailingAnchor.constraint(equalTo: heading.trailingAnchor)
            
        ])
    }
    
    private func configSubHeading(){
        NSLayoutConstraint.activate([
            overallLbl.topAnchor.constraint(equalTo: detailsLbl.bottomAnchor, constant: 20),
            overallLbl.leadingAnchor.constraint(equalTo: detailsLbl.leadingAnchor),
            overallLbl.trailingAnchor.constraint(equalTo: detailsLbl.trailingAnchor),
            overallLbl.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configCardView(){
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: overallLbl.bottomAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: overallLbl.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: overallLbl.trailingAnchor),
            cardView.heightAnchor.constraint(equalToConstant: 200),
            
        ])
    }
    
    private func configDashboard(){
        healthCard.setImage(UIImage(named: "health_card_bg"))
        healthCard.setLbl(label: "Terrarium is in good shape!")
        
        cardView.addSubViews(healthCard, temperatureCard,humidityCard, waterCard, amountWaterCard)
        
        amountWaterCard.frame = CGRect(x: 50, y: 100, width: 300, height: 150) 
        amountWaterCard.setWaterAmount(150)
        
        NSLayoutConstraint.activate([
            healthCard.topAnchor.constraint(equalTo: cardView.topAnchor),
            healthCard.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            healthCard.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            healthCard.heightAnchor.constraint(equalToConstant: 200),
            
            temperatureCard.topAnchor.constraint(equalTo: healthCard.bottomAnchor, constant:  20),
            temperatureCard.leadingAnchor.constraint(equalTo: healthCard.leadingAnchor),
            temperatureCard.widthAnchor.constraint(equalTo: humidityCard.widthAnchor),
            temperatureCard.heightAnchor.constraint(equalToConstant:150),
            
            humidityCard.topAnchor.constraint(equalTo: temperatureCard.topAnchor),
            humidityCard.leadingAnchor.constraint(equalTo: temperatureCard.trailingAnchor, constant: 20),
            humidityCard.heightAnchor.constraint(equalTo: temperatureCard.heightAnchor),
            humidityCard.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            waterCard.topAnchor.constraint(equalTo: temperatureCard.bottomAnchor, constant: 20),
            waterCard.leadingAnchor.constraint(equalTo: healthCard.leadingAnchor),
            waterCard.widthAnchor.constraint(equalTo: temperatureCard.widthAnchor),
            waterCard.heightAnchor.constraint(equalTo: temperatureCard.heightAnchor),
            
            amountWaterCard.topAnchor.constraint(equalTo: waterCard.topAnchor),
            amountWaterCard.leadingAnchor.constraint(equalTo: waterCard.trailingAnchor, constant: 20),
            amountWaterCard.heightAnchor.constraint(equalTo: waterCard.heightAnchor),
            amountWaterCard.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
            
            
            
            
            
        ])
    }
    
    private func configCharts() {
        // Common setup for all charts
        [temperatureChart, humidityChart, moistureChart].forEach { chart in
            chart.rightAxis.enabled = false
            chart.xAxis.labelPosition = .bottom
            chart.animate(xAxisDuration: 1.5)
            chart.legend.enabled = true
            chart.isUserInteractionEnabled = false
            
            // Add to view
            contentView.addSubview(chart)
        }
        
        // Customize each chart
        temperatureChart.legend.form = .circle
        temperatureChart.chartDescription.text = "Temperature (°C)"
        
        humidityChart.legend.form = .circle
        humidityChart.chartDescription.text = "Humidity (%)"
        
        moistureChart.legend.form = .circle
        moistureChart.chartDescription.text = "Moisture (%)"
        
        //Setup constraints:
        temperatureChart.translatesAutoresizingMaskIntoConstraints = false
        humidityChart.translatesAutoresizingMaskIntoConstraints = false
        moistureChart.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Temperature Chart
            temperatureChart.topAnchor.constraint(equalTo: amountWaterCard.bottomAnchor, constant: 20),
            temperatureChart.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            temperatureChart.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            temperatureChart.heightAnchor.constraint(equalToConstant: 200),
            
            // Humidity Chart
            humidityChart.topAnchor.constraint(equalTo: temperatureChart.bottomAnchor, constant: 20),
            humidityChart.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            humidityChart.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            humidityChart.heightAnchor.constraint(equalToConstant: 200),
            
            // Moisture Chart
            moistureChart.topAnchor.constraint(equalTo: humidityChart.bottomAnchor, constant: 20),
            moistureChart.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            moistureChart.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            moistureChart.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    
    func extractChartData(from sensorDatas: [SensorDataResponse], limit: Int = 10) -> (temperatureData: [ChartDataEntry], humidityData: [ChartDataEntry], moistureData: [ChartDataEntry]) {
        var temperatureEntries: [ChartDataEntry] = []
        var humidityEntries: [ChartDataEntry] = []
        var moistureEntries: [ChartDataEntry] = []
        
        // Extract the last 'limit' records
        let recentData = sensorDatas.suffix(limit)
        
        for (index, data) in recentData.enumerated() {
            let xValue = Double(index) // Use the index within the recent data as x-axis value
            
            // Extract temperature data
            if let temperature = data.temperature {
                temperatureEntries.append(ChartDataEntry(x: xValue, y: temperature))
            }
            
            // Extract humidity data
            if let humidity = data.humidity {
                humidityEntries.append(ChartDataEntry(x: xValue, y: humidity))
            }
            
            // Extract moisture data
            if let moisture = data.moisture {
                moistureEntries.append(ChartDataEntry(x: xValue, y: moisture))
            }
        }
        
        print(temperatureEntries)
        print(humidityEntries)
        print(moistureEntries)
        return (temperatureEntries, humidityEntries, moistureEntries)
    }

    func updateCharts(with data: [SensorDataResponse]) {
        let chartData = extractChartData(from: data, limit: 10)
        
        // Temperature Chart
        let temperatureDataSet = LineChartDataSet(entries: chartData.temperatureData, label: "Temperature")
        temperatureDataSet.setColor(.red)
        temperatureDataSet.drawCirclesEnabled = false
        temperatureDataSet.lineWidth = 2
        temperatureDataSet.mode = .cubicBezier
        temperatureChart.data = LineChartData(dataSet: temperatureDataSet)
        
        // Humidity Chart
        let humidityDataSet = LineChartDataSet(entries: chartData.humidityData, label: "Humidity")
        humidityDataSet.setColor(.blue)
        humidityDataSet.drawCirclesEnabled = false
        humidityDataSet.lineWidth = 2
        humidityDataSet.mode = .cubicBezier
        humidityChart.data = LineChartData(dataSet: humidityDataSet)
        
        // Moisture Chart
        let moistureDataSet = LineChartDataSet(entries: chartData.moistureData, label: "Moisture")
        moistureDataSet.setColor(.green)
        moistureDataSet.drawCirclesEnabled = false
        moistureDataSet.lineWidth = 2
        moistureDataSet.mode = .cubicBezier
        moistureChart.data = LineChartData(dataSet: moistureDataSet)
    }
    
    func handleConnectionStatus(_ isOnline: Bool) {
        if !isOnline{
            showOfflineAlert()
        }
            
        
    }
    
    private func showOfflineAlert() {
        let alertController = UIAlertController(
            title: "Connection Error",
            message: "The server appears to be offline. Please check your internet connection and try again.",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true)
        }
    }

    
    
}
