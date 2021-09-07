//
//  TestUIComponents.swift
//  GitReposSampleTests
//
//  Created by Blue Peak Systems on 9/7/21.
//

import XCTest
@testable import GitReposSample

class TestUIComponents: XCTestCase {
    
    var viewController: ViewController!
    var tableView: UITableView!
    override func setUp() {
        viewController = ViewController()
        _ = viewController.view
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 200, height: 400), style: .plain)
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "Cell")
        let expectations = expectation(description: "GitRepoAPI_Valid_Request_Returns_Success")
//        ACT
        viewController.reloadRepositories("Swif")
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            expectations.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    func testTableView() {
        XCTAssertNotNil(viewController.tableView)
    }
    func testTableDataSource() {
        XCTAssertTrue(viewController.tableView.dataSource is DataProvider)
    }
    func testTableDelegate() {
        XCTAssertTrue(viewController.tableView.delegate is DataProvider)
    }
    func testAwakeFromNib() {
        let indexPath = IndexPath(row: 0, section: 0)
        _ = createCell(indexPath: indexPath)
    }
    func createCell(indexPath: IndexPath) -> RepoTableViewCell {
        let cell = viewController.tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as! RepoTableViewCell
        XCTAssertNotNil(cell)
        
        let view = cell.contentView
        XCTAssertNotNil(view)
        
        return cell
    }
    func testPagination() {
        viewController.tableView.scrollToRow(at: IndexPath(row: Constants.perPageResults-1, section: 0), at: .bottom, animated: true)
    }
    func testDidSelectTable() {
        guard let dataProvider = viewController.tableView.dataSource as? DataProvider else { return }
        dataProvider.tableView(viewController.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }
    func testAlert() {
        viewController.showAlert("Sample")
    }
    override func tearDownWithError() throws {
        viewController = nil
    }
}



