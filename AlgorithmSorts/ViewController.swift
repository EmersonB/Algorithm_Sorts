//
//  ViewController.swift
//  AlgorithmSorts
//
//  Created by Emerson Berlik on 3/10/20.
//  Copyright © 2020 Emerson Berlik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var sliderLabel = UILabel()
    let sortedLabel = UILabel()
    var num_elements = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let gifURL : String = "https://upload.wikimedia.org/wikipedia/commons/c/cc/Merge-sort-example-300px.gif"
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
        slider.addTarget(self, action: #selector(ViewController.sliderValueDidChange(_:)), for: .valueChanged)
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
        mainView.addSubview(sortedLabel)
        mainView.addSubview(button)
        view.addSubview(mainView)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        let merge_me = Array(getRandomNumbers(maxNumber: 100,listSize: num_elements))
        print(merge_me)
        let result = mergeSort(merge_me)
        print("sort me")
        print(result)
        sortedLabel.text = result.description
        
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
    
    func mergeSort(_ array: [Int]) -> [Int] {
      guard array.count > 1 else { return array }

      let middleIndex = Int(array.count / 2)
      
      let leftArray = mergeSort(Array(array[0..<middleIndex]))
      let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
      
      // here
      return merge(leftArray, rightArray)
    }
    
    func merge(_ left: [Int], _ right: [Int]) -> [Int] {
      var leftIndex = 0
      var rightIndex = 0

      var orderedArray: [Int] = []
      
      // 1
      while leftIndex < left.count && rightIndex < right.count {
        // 1
        let leftElement = left[leftIndex]
        let rightElement = right[rightIndex]

        if leftElement < rightElement { // 2
          orderedArray.append(leftElement)
          leftIndex += 1
        } else if leftElement > rightElement { // 3
          orderedArray.append(rightElement)
          rightIndex += 1
        } else { // 4
          orderedArray.append(leftElement)
          leftIndex += 1
          orderedArray.append(rightElement)
          rightIndex += 1
        }
      }

      // 2
      while leftIndex < left.count {
        orderedArray.append(left[leftIndex])
        leftIndex += 1
      }

      while rightIndex < right.count {
        orderedArray.append(right[rightIndex])
        rightIndex += 1
      }
      
      return orderedArray
    }
}

