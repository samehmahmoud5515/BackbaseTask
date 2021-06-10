//
//  Bundle.swift
//  BackbaseTaskTests
//
//  Created by SAMEH on 10/06/2021.
//

import Foundation

extension Bundle {
    private class Test {}

    public class var unitTest: Bundle {
        return Bundle(for: Test.self)
    }
}
