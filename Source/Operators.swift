//
//  Operators.swift
//  RxSwiftForms
//
//  Created by Bonk, Thomas on 26.04.17.
//
//

import Foundation
import SwiftForms

// MARK: Operators
precedencegroup FormPrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}

precedencegroup SectionPrecedence {
    associativity: left
    higherThan: FormPrecedence
}

infix operator +++ : FormPrecedence

/**
 Appends a section to a form
 
 - parameter left:  the form
 - parameter right: the section to be appended
 
 - returns: the updated form
 */
@discardableResult
public func +++ (left: FormDescriptor, right: FormSectionDescriptor) -> FormDescriptor {
    left.sections.append(right)
    return left
}

/**
 Appends a row to the last section of a form
 
 - parameter left:  the form
 - parameter right: the row
 */
@discardableResult
public func +++ (left: FormDescriptor, right: FormRowDescriptor) -> FormDescriptor {
    let section = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
    let _ =  left +++ section <<< right
    return left
}

/**
 Creates a form with two sections
 
 - parameter left:  the first section
 - parameter right: the second section
 
 - returns: the created form
 */
@discardableResult
public func +++ (left: FormSectionDescriptor, right: FormSectionDescriptor) -> FormDescriptor {
    let form = FormDescriptor()
    let _ =  form +++ left +++ right
    return form
}

/**
 Appends the row wrapped in a new section
 
 - parameter left: a section of the form
 - parameter right: a row to be appended
 
 - returns: the form
 */
@discardableResult
public func +++ (left: FormSectionDescriptor, right: FormRowDescriptor) -> FormDescriptor {
    let section = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
    section <<< right
    return left +++ section
}

/**
 Creates a form with two sections, each containing one row.
 
 - parameter left:  The row for the first section
 - parameter right: The row for the second section
 
 - returns: the created form
 */
@discardableResult
public func +++ (left: FormRowDescriptor, right: FormRowDescriptor) -> FormDescriptor {
    let form = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
                <<< left
                +++ FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
                <<< right
    return form
}

infix operator <<< : SectionPrecedence

/**
 Appends a row to a section.
 
 - parameter left:  the section
 - parameter right: the row to be appended
 
 - returns: the section
 */
@discardableResult
public func <<< (left: FormSectionDescriptor, right: FormRowDescriptor) -> FormSectionDescriptor {
    left.rows.append(right)
    return left
}

/**
 Creates a section with two rows
 
 - parameter left:  The first row
 - parameter right: The second row
 
 - returns: the created section
 */
@discardableResult
public func <<< (left: FormRowDescriptor, right: FormRowDescriptor) -> FormSectionDescriptor {
    let section = FormSectionDescriptor(headerTitle: nil, footerTitle: nil)
    section <<< left <<< right
    return section
}
