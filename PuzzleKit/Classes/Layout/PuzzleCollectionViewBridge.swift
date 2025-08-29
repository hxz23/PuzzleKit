//
//  PuzzleCollectionViewBridge.swift
//  PuzzleKit
//
//  Created by 郝学智 on 2021/7/22.
//

import Foundation

public class PuzzleCollectionViewBridge: NSObject {
    weak var collectionView: UICollectionView?

    weak var adapter: PuzzleCollectionViewAdapter?

    public let layout = PuzzleLayout()

    private var uiComponents = [PuzzleDisplayComponent]()

    private var sectionToUIComponentMap = [Int: PuzzleDisplayComponent]()

    private var registeredCellIdentifiers = [String]()

    func reload(completion: (PuzzleCollectionViewAdapter.Completion?) = nil) {
        sectionToUIComponentMap.removeAll()
        uiComponents.removeAll()

        if let width = collectionView?.frame.width, width <= 0 {
            collectionView?.setNeedsLayout()
            collectionView?.layoutIfNeeded()
        }
        if let width: CGFloat = collectionView?.frame.width {
            layout.context = PuzzleContext(width: width)
        }

        guard let logicList = adapter?.logicComponents else { return }

        var index = 0

        let context = layout.context

        for loginCp in logicList {
            if let uiList = loginCp.dataSource?.uiComponents(puzzleContext: context) {
                loginCp.displayUIComponents = uiList
                for uiCp in uiList {
                    uiCp.logicComponent = loginCp
                    uiCp.extra.sectionIndex = index
                    uiComponents.append(uiCp)
                    sectionToUIComponentMap[index] = uiCp
                    for item in uiCp.vmList {
                        item.uiComponent = uiCp
                        item.eventBus = uiCp.logicComponent?.adapter?.eventBus
                    }
                    index += 1
                }
            }
        }

        layout.updateUIComponents(uiComponents)
        collectionView?.reloadData {
            completion?()
        }
    }
}

extension UICollectionView {
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}

extension PuzzleCollectionViewBridge: UICollectionViewDataSource {
    public func numberOfSections(in _: UICollectionView) -> Int {
        uiComponents.count
    }

    public func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sectionToUIComponentMap[section]?.itemCount ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let uiCp = sectionToUIComponentMap[indexPath.section] else {
            return UICollectionViewCell()
        }
        let attribute = uiCp.attributesList[indexPath.item]

        let identifiers = attribute.viewClass.description()
        if !registeredCellIdentifiers.contains(identifiers) {
            registeredCellIdentifiers.append(identifiers)
            collectionView.register(attribute.viewClass, forCellWithReuseIdentifier: identifiers)
        }

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifiers, for: indexPath)

        (cell as? PuzzleCellProtocol)?.update(attribute.viewModel)

        return cell
    }
}

extension PuzzleCollectionViewBridge: UICollectionViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        adapter?.puzzleViewDidScroll(scrollView: scrollView)
    }

    public func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt _: IndexPath) {
        if let new = cell as? PuzzleCellProtocol {
            new.willDisplay()
        }
    }

    public func collectionView(_: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt _: IndexPath) {
        if let new = cell as? PuzzleCellProtocol {
            new.didEndDisplaying()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? PuzzleCellProtocol {
            cell.didSelected()
        }
    }
}
