//
//  InsertionSortViewController.swift
//  AlgorithmSorts
//
//  Created by Rohan Taneja on 3/13/20.
//  Copyright © 2020 Emerson Berlik. All rights reserved.
//

import UIKit

class InsertionSortViewController: UIViewController {
    
    var sliderLabel = UILabel()
    let sortedLabel = UILabel()
    let shiftsLabel = UILabel()
    var num_elements = 0;
    var shifts = 0;
    @objc func backAction(){
        //print("Back Button Clicked")
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        let gifURL : String = "https://upload.wikimedia.org/wikipedia/commons/0/0f/Insertion-sort-example-300px.gif"
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
        slider.addTarget(self, action: #selector(InsertionSortViewController.sliderValueDidChange(_:)), for: .valueChanged)
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
        shiftsLabel.frame = CGRect(x: 20.0, y:170.0, width: self.view.frame.size.width - 100, height: 20.0)
        mainView.addSubview(sortedLabel)
        mainView.addSubview(shiftsLabel)
        mainView.addSubview(button)
        view.addSubview(mainView)

    }
    
    @objc func buttonAction(sender: UIButton!) {
        var insertion_me = Array(getRandomNumbers(maxNumber: 100,listSize: num_elements))
        print("Unsorted list ", insertion_me)
        print("sorting...")
        let result = insertionSort(array: &insertion_me)
        print("Sorted list ",result)
        sortedLabel.text = result.description
        shiftsLabel.text = "Total # of Shifts: " + String(shifts)
        shifts = 0
        
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
    
    func insertionSort(array: inout [Int]) -> [Int] {
        guard array.count > 0 else { return array }
        for i in 1..<array.count{
            var curr = array[i]
            var previous_index = i - 1
            while(previous_index >= 0 && array[previous_index] > curr){
                array[previous_index + 1] = array[previous_index]
                previous_index -= 1
                shifts += 1
            }
            array[previous_index + 1] = curr
        }
        return array
    }
    
}

