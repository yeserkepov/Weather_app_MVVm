//
//  ViewController.swift
//  weather_app_MVVm
//
//  Created by Даурен on 30.07.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentCity: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tempFeels: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    private var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.setup()
        setupVC()
    }

    func setupVC(){
        self.viewModel.cityLabel.bind { txt in
            self.currentCity.text = txt
        }
        self.viewModel.dateLabel.bind { txt in
            self.date.text = txt
        }
        self.viewModel.tempLabel.bind { txt in
            self.temp.text = txt
        }
        self.viewModel.descriptionLabel.bind { txt in
            self.descriptionLabel.text = txt
        }
        self.viewModel.tempFeelsLabel.bind { txt in
            self.tempFeels.text = txt
        }
        self.viewModel.tempMinLabel.bind { txt in
            self.tempMin.text = txt
        }
        self.viewModel.tempMaxLabel.bind { txt in
            self.tempMax.text = txt
        }
        self.viewModel.iconsName.bind { icon in
            self.iconImage.image = UIImage(named: icon)
        }
    }


}

