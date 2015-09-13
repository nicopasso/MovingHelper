//
//  TaskLoader.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/7/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import UIKit

/*
Struct to load tasks from JSON.
*/
public struct TaskLoader {
  
  static func loadSavedTasksFromJSONFile(fileName: FileName) throws -> [Task]? {
    let path = fileName.jsonFileName().pathInDocumentsDirectory()
    if let data = NSData(contentsOfFile: path) {
      return try tasksFromData(data)
    } else {
      return nil
    }
  }
  
  
  /**
  - returns: The stock moving tasks included with the app.
  */
  public static func loadStockTasks() -> [Task] {
    do {
        if let path = NSBundle.mainBundle()
            .pathForResource(FileName.StockTasks.rawValue, ofType: "json"),
            data = NSData(contentsOfFile: path),
            tasks = try tasksFromData(data) {
                return tasks
        }
    } catch {
        
    }

    //Fall through case
    NSLog("Tasks did not load!")
    return [Task]()
  }
  
  private static func tasksFromData(data: NSData) throws -> [Task]?  {
    let error = NSErrorPointer()
    if let arrayOfTaskDictionaries = try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [NSDictionary] {
      return Task.tasksFromArrayOfJSONDictionaries(arrayOfTaskDictionaries)
    } else {
      NSLog("Error loading data: " + error.debugDescription)
      return nil
    }
  }
}