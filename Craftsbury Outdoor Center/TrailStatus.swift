//
//  TrailStatus.swift
//  CraftsburySkiing
//
//  Created by Philip Henson on 8/18/15.
//  Copyright (c) 2015 Philip Henson. All rights reserved.
//

import UIKit

class TrailStatus {

    var snowfallData: String?
    var kmOpenData: String?

    var trailNamesData = [String]()
    var trailLengthsData = [String]()
    var trailStatusData = [String]()
    var trailDateGroomed = [String]()
    var trailNote = [String]()
    var trailDifficulty = [String]()


    let queryStrings: [String] = [
        "//div[@id='snow-details']/p/span[@class='data']",
        "//div[@id='kilometers-open']/p/span[@class='data']",
        "//div[@id='trail-conditions']/table//td",
        "//div[@id='trail-conditions']/table/tr/td/span[@class='trail-name']",
        "//div[@id='trail-conditions']/table/tr/td/span[@class]"
    ]
        


    init(){

        // Parse HTML
        let snowReportURL = "http://craftsbury.com/skiing/nordic_center/snow_report.htm"
        if let url = NSURL(string: snowReportURL){
            if let snowReportData = NSData(contentsOfURL: url){
                if let snowReportParser = TFHpple(HTMLData: snowReportData){

                    // Just like WeatherData.swift, can probably improve this
                    var snowDetails = snowReportParser.searchWithXPathQuery(queryStrings[0])
                    var kmOpen = snowReportParser.searchWithXPathQuery(queryStrings[1])
                    var trailConditions = snowReportParser.searchWithXPathQuery(queryStrings[2])
                    var trailNames = snowReportParser.searchWithXPathQuery(queryStrings[3])
                    var trailNodes = snowReportParser.searchWithXPathQuery(queryStrings[4])

                    // Set class variables with parsed data
                    var element = snowDetails[1] as! TFHppleElement
                    if (element.text() == nil || element.text() == "0"){
                        self.snowfallData = "0 in"
                    } else{
                        if var editString = element.text(){
                            if let range = editString.rangeOfString("\""){
                                editString.removeRange(range)
                                editString.splice(" in", atIndex: editString.endIndex.predecessor())
                                self.snowfallData = editString
                            }
                        }

                    }

                    element = kmOpen[0] as! TFHppleElement
                    if (element.text() == nil || element.text() == "0"){
                        self.kmOpenData = "0 km"
                    } else {
                        self.kmOpenData = element.text()
                    }

                    var counter = 0

                    while (counter + 2 <= trailConditions.count){
                        element = trailConditions[counter] as! TFHppleElement
                            if (element.attributes["class"]?.value == "trail-kilmoeters"){
                                self.trailLengthsData.append(element.text())
                                element = trailConditions[counter+1] as! TFHppleElement
                                if (element.text() == "CLOSED"){
                                    self.trailStatusData.append("CLOSED")
                                    self.trailDateGroomed.append("--")
                                    self.trailNote.append(" ")
                                }
                                else {
                                    self.trailStatusData.append("OPEN")
                                    self.trailDateGroomed.append(element.text())
                                    element = trailConditions[counter+2] as! TFHppleElement

                                    if var editString = element.text(){
                                        if let range = editString.rangeOfString("\\u00a0"){
                                            editString.removeRange(range)
                                            editString.insert(" ", atIndex: range.startIndex)
                                            self.trailNote.append(editString)
                                        }
                                    }
                                    counter++
                                }

                            }


                    }

                    // NOT SURE IF THIS WORKS
                    for element in trailNames as! Array<TFHppleElement>{
                        if var editString = element.text(){
                            if let range = editString.rangeOfString("\\u00a0"){
                                editString.removeRange(range)
                                editString.insert(" ", atIndex: range.startIndex)
                                self.trailNamesData.append(editString)
                            }
                        }

                    }

                    //Get Trail Difficulty

                    for element in trailNodes as! Array<TFHppleElement>{
                        if (element["class"] == "beginner trail-number"){
                            self.trailDifficulty.append("beginner")
                        }
                        else if (element["class"] == "intermediate trail-number"){
                            self.trailDifficulty.append("intermediate")
                        }
                        else if (element["class"] == "advanced trail-number"){
                            self.trailDifficulty.append("advanced")
                        }
                        else if (element["class"] == "na trail-number"){
                            self.trailDifficulty.append("na trail-number")
                        }

                    }





                }
            }
        }





    }

}