//
//  ViewController.swift
//  Access Data Using Web Api Covid-19
//
//  Created by NTS on 30/01/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var confirmCasesLabel: UILabel!
    @IBOutlet weak var totalDeathLabel: UILabel!
    @IBOutlet weak var newConfirmCasesLabel: UILabel!
    
    var t: String = ""
    var liveData = CovidCases(totalconfirmed: "", dailyrecovered: "", totaldeceased: "", dailyconfirmed: "", dailydeceased: "", date: "", dateymd: "", totalrecovered: "")
    
    var covidStatus = CovidCases(totalconfirmed: "", dailyrecovered: "", totaldeceased: "", dailyconfirmed: "", dailydeceased: "", date: "", dateymd: "", totalrecovered: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayStatus()
    }
    
    func displayStatus(){
        URLSession.shared.dataTask(with: URL(string: "https://data.covid19india.org/data.json")!) { data, response, error in
            guard let liveData = data, error == nil else {
                return
            }
            var currentStatus : CovidResult?
            
            do{
                currentStatus = try JSONDecoder().decode(CovidResult.self, from: liveData)
            }catch{
                print(error)
            }
            
            guard let finalStatus = currentStatus else {
                return
            }
            let covid = finalStatus.cases_time_series
            
            DispatchQueue.main.async {
                self.confirmCasesLabel.text = covid!.totalconfirmed
                self.newConfirmCasesLabel.text = covid!.dailyrecovered
                self.totalDeathLabel.text = covid!.totaldeceased
            }
        }.resume()
    }

}


struct CovidCases: Codable
{
    let totalconfirmed: String
    let dailyrecovered: String
    let totaldeceased: String
    let dailyconfirmed: String
    let dailydeceased: String
    let date: String
    let dateymd: String
    let totalrecovered: String
}

private enum CodingKeys: String, CodingKey
{
    case
    totalconfirmed, dailyrecovered, totaldeceased, dailyconfirmed, date, dateymd, totalrecovered
}

struct CovidResult: Codable
{
    let cases_time_series: CovidCases?
}
