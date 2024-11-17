//
//  Closures.swift
//  Swift.Org_Conepts
//
//  Created by Nagaraju on 15/11/24.
//

//1.what is the closures
//2. Types of closures type
//3. memory mangage ment


import Foundation
import SwiftUI

struct writeClsoures {
    var passArray:(([Int]) -> Void)
    func loadFuncaion(items:[Int]) {
        passArray(items)
    }
}

