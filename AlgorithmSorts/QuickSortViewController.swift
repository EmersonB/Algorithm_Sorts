//
//  QuickSortViewController.swift
//  AlgorithmSorts
//
//  Created by Rohan Taneja on 3/11/20.
//  Copyright © 2020 Emerson Berlik. All rights reserved.
//

import UIKit

class QuickSortViewController: UIViewController {
    
    var sliderLabel = UILabel()
    var swaps = 0;
    let sortedLabel = UILabel()
    let swapsLabel = UILabel()
    var num_elements = 0;
    @objc func backAction(){
        //print("Back Button Clicked")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        let gifURL : String = "https://upload.wikimedia.org/wikipedia/commons/9/9c/Quicksort-example.gif"
        let imageURL = UIImage.gifImageWithURL(gifURL)
        let imageView = UIImageView(image: imageURL)
        imageView.frame = CGRect(x: 20.0, y: 50.0, width: self.view.frame.size.width - 40, height: 150.0)
        view.addSubview(imageView)
        let slider = UISlider()
        slider.isContinuous = true
        slider.minimumValue = 0
        slider.maximumValue = 100
        sliderLabel.text = "0"
        sliderLabel.frame = CGRect(x: 20.0, y:50.0, width: self.view.frame.size.width - 100, height: 20.0)
        slider.addTarget(self, action: #selector(QuickSortViewController.sliderValueDidChange(_:)), for: .valueChanged)
        slider.frame = CGRect(x: 20.0, y:70.0, width: self.view.frame.size.width - 100, height: 20.0)
        let mainView = UIView()
        mainView.frame = CGRect(x:20.0,y:200.0,width:self.view.frame.size.width - 40, height:150.0)
        mainView.addSubview(sliderLabel)
        mainView.addSubview(slider)
        
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .blue
        button.setTitle("Sort", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        sortedLabel.frame = CGRect(x: 20.0, y:150.0, width: self.view.frame.size.width - 100, height: 20.0)
        swapsLabel.frame = CGRect(x: 20.0, y:170.0, width: self.view.frame.size.width - 100, height: 20.0)
        mainView.addSubview(sortedLabel)
        mainView.addSubview(swapsLabel)
        mainView.addSubview(button)
        view.addSubview(mainView)

    }
    
    @objc func buttonAction(sender: UIButton!) {
        var quick_me = Array(getRandomNumbers(maxNumber: 100,listSize: num_elements))
        print("Unsorted list ", quick_me)
        print("sorting...")
        let result = quickSort(array: &quick_me, 0, quick_me.count - 1)
        print("Sorted list ",result)
        sortedLabel.text = result.description
        swapsLabel.text = "Total # of Swaps: " + String(swaps)
        swaps = 0
        
    }
    
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        // Use this code below only if you want UISlider to snap to values step by step
        let roundedStepValue = round(sender.value)
        //sender.value = roundedStepValue
        
        num_elements = Int(roundedStepValue)
        sliderLabel.text = String(Int(roundedStepValue))
    }

    func getRandomNumbers(maxNumber: Int, listSize: Int)-> Set<Int> {
        var randomNumbers = Set<Int>()
        while randomNumbers.count < listSize {
            let randomNumber = Int(arc4random_uniform(UInt32(maxNumber+1)))
            randomNumbers.insert(randomNumber)
        }
        return randomNumbers
    }
    
    func quickSort(array: inout [Int], _ low: Int, _ high: Int) -> [Int] {
      guard low < high else { return array }
        let pivot = partition(array: &array, low, high)
        array = quickSort(array: &array, low, pivot-1)
        array = quickSort(array: &array, pivot+1, high)
      
      // here
        return array
    }
    func partition(array: inout [Int], _ low: Int, _ high: Int) -> Int {
        var start = low
        for i in low..<high {
            if(array[i] < array[high]){
                (array[start], array[i]) = (array[i], array[start])
                print("swapping...")
                start += 1
                swaps += 1
            }
        }
        (array[start], array[high]) = (array[high], array[start])
        print("pivot", array[start])
        print("partitioned array", array)
        return start
    }
    
}

