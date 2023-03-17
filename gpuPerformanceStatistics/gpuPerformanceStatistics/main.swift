//
//  main.swift
//  gpuPerformanceStatistics
//
//  Created by Xavier Rey-Robert

import Foundation

import IOKit
import IOKit.graphics

func queryPerformanceStatistic(matchingString: String) {
    let serviceMatchingDictionary = IOServiceMatching(matchingString)
    var iterator: io_iterator_t = 0
    
    let result = IOServiceGetMatchingServices(kIOMainPortDefault, serviceMatchingDictionary, &iterator)
    guard result == KERN_SUCCESS else {
        print("Failed to get matching services: \(result)")
        return
    }
    
    var acceleratorService: io_object_t = IOIteratorNext(iterator)
    while acceleratorService != 0 {
        let performanceStats = IORegistryEntryCreateCFProperty(acceleratorService, "PerformanceStatistics" as CFString, kCFAllocatorDefault, 0)
        var first = true
        
        if let stats = performanceStats?.takeRetainedValue() as? [String: Any] {
            // Do something with the performance statistics
            print(stats)
            print ("{")
         
            for (key, value) in stats {
                if (!(first == true)) { print (",") }
                else { first = false }
                print ("\""+key+"\""," : ", value, terminator: "")
            }
            print ("}")
        }
        
        IOObjectRelease(acceleratorService)
        acceleratorService = IOIteratorNext(iterator)
    }
    
    IOObjectRelease(iterator)
}


// Get the command line arguments&
let arguments = CommandLine.arguments

// Make sure at least one argument was provided
guard arguments.count > 1 else {
    print("Usage: gpuPerformanceStatistics className")
    print("")
    print("Ex: (Intel Mac Pro with amd GPU) gpuPerformanceStatistics AMDRadeonX6000_AMDNavi23GraphicsAccelerator")
    print("    (AppleSilicon M1) gpuPerformanceStatistics AGXAcceleratorG13X")
    exit(1)
}

// Call the function with the provided argument
let matchingString = arguments[1]
queryPerformanceStatistic(matchingString: matchingString)
