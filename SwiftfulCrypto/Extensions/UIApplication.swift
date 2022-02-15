//
//  UIApplication.swift
//  SwiftfulCrypto
//
//  Created by Guillaume Ramey on 15/02/2022.
//

import SwiftUI

extension UIApplication {
  func endEditing() {
    sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
  }
}
