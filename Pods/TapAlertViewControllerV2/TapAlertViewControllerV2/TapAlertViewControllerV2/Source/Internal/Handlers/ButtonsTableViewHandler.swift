//
//  ButtonsTableViewHandler.swift
//  TapAlertViewController
//
//  Copyright © 2019 Tap Payments. All rights reserved.
//

import class	UIKit.UITableView.UITableView
import protocol	UIKit.UITableView.UITableViewDataSource
import protocol	UIKit.UITableView.UITableViewDelegate
import class	UIKit.UITableViewCell.UITableViewCell

internal final class ButtonsTableViewHandler: NSObject {
	
	// MARK: - Internal -
	
	internal typealias Delegate = ButtonsTableViewHandlerDelegate
	
	// MARK: Properties
	
	internal weak var delegate: Delegate?
	
	internal var actions: [ActionProtocol] = [] {
		
		didSet {
			
			self.actionsDidUpdate()
		}
	}
	
	internal weak var tableView: UITableView? {
		
		didSet {
			
			self.tableView?.dataSource	= self
			self.tableView?.delegate	= self
			
			self.actionsDidUpdate()
		}
	}
	
	// MARK: - Private -
	// MARK: Properties
	
	private var tableViewContentSizeObservation: NSKeyValueObservation?
	
	// MARK: Methods
	
	private func actionsDidUpdate() {
		
		self.tableView?.reloadData()
	}
	
	private func setupTableViewContentSizeObserver() {
		
		guard let nonnullTableView = self.tableView else {
			
			self.tableViewContentSizeObservation = nil
			return
		}
		
		self.tableViewContentSizeObservation = nonnullTableView.observe(\.contentSize, options: [.initial, .old, .new], changeHandler: { [weak self] (table, change) in
			
			guard let strongSelf = self else { return }
			
			let newSize = change.newValue ?? .zero
			strongSelf.delegate?.buttonsTableViewHandler(strongSelf, tableViewContentSizeChangedTo: newSize)
		})
	}
}

// MARK: - UITableViewDataSource
extension ButtonsTableViewHandler: UITableViewDataSource {
	
	internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return self.actions.count
	}
	
	internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let action = self.actions[indexPath.row]
		
		let style = action.buttonCellStyle
		guard let cell = tableView.dequeueReusableCell(withIdentifier: style.cellReuseIdentifier) else {
			
			fatalError("\(style.cellReuseIdentifier) cannot be instantiated.")
		}
		
		return cell
	}
}

// MARK: - UITableViewDelegate
extension ButtonsTableViewHandler: UITableViewDelegate {
	
	internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		guard let actionCell = cell as? ActionTableViewCell else { return }
		
		let action = self.actions[indexPath.row]
		actionCell.setup(with: action)
		actionCell.delegate = self
	}
}

// MARK: - ActionTableViewCellDelegate
extension ButtonsTableViewHandler: ActionTableViewCellDelegate {
	
	internal func actionCell(_ cell: ActionTableViewCell, buttonClickedFor action: TapAlertAction) {
		
		action.clickCallback(action)
	}
}
