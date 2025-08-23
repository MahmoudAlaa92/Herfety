//
//  ReviewersViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 03/03/2025.
//

import Combine

final class ReviewersViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var reviewersItems: [ReviewrItem] = []
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var sectionsLayout: [LayoutSectionProvider] = []
    
    // MARK: - Dependencies
    private let dataSource: ReviewersDataSource
    private let sectionConfigurator: ReviewersSectionConfiguratorProtocol
    private weak var coordinator: ReviewersTransitionDelegate?
    
    // MARK: - Properties
    let productId: Int
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(dataSource: ReviewersDataSource,
         sectionConfigurator: ReviewersSectionConfiguratorProtocol,
         productId: Int,
         coordinator: ReviewersTransitionDelegate,
         reviews: [ReviewrItem] = []) {
        self.dataSource = dataSource
        self.sectionConfigurator = sectionConfigurator
        self.productId = productId
        self.coordinator = coordinator
        self.reviewersItems = reviews
        
        configureSectionsAndLayouts()
    }
}
// MARK: - Public Methods
//
extension ReviewersViewModel {
    func fetchReviews() async {
        do {
            reviewersItems = try await dataSource.fetchReviews(productId: productId)
            configureSectionsAndLayouts()
        } catch {
            print("Error fetching reviews: \(error)")
        }
    }
    
    @MainActor
    func refreshSections() async {
        configureSectionsAndLayouts()
    }
}
// MARK: - Private Methods
//
extension ReviewersViewModel {
    private func configureSectionsAndLayouts() {
        
        sections = sectionConfigurator.configureSections(
            reviewers: reviewersItems,
            onDelete: { [weak self] index in
                Task { await self?.deleteReview(at: index) }
            },
            onUpdate: { [weak self] index, newText in
                Task { await self?.updateReview(at: index, with: newText) }
            }
        )
        
        sectionsLayout = sectionConfigurator.configureLayoutSections()
    }
    
    private func deleteReview(at index: Int) async {
        do {
            let success = try await dataSource.deleteReview(
                review: reviewersItems[index],
                at: index
            )
            if success {
                reviewersItems.remove(at: index)
                await refreshSections()
            }
        } catch {
            print("❌ Failed to delete review: \(error)")
        }
    }
    
    private func updateReview(at index: Int, with newText: String) async {
        do {
            let updatedReview = try await dataSource.updateReview(
                review: reviewersItems[index],
                newText: newText,
                productId: productId
            )
            reviewersItems[index] = updatedReview
            await refreshSections()
        } catch {
            print("❌ Failed to update review: \(error)")
        }
    }
}
