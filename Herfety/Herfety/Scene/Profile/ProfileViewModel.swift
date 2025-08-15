
import UIKit
import Combine

final class ProfileViewModel {
    /// Input ViewModels
    private let nameViewModel: NameViewModel
    private let profileListViewModel: ProfileListViewModel
    
    /// Outputs
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutSections: [LayoutSectionProvider] = []
    
    private var cancellables = Set<AnyCancellable>()
    weak var coordinator: PorfileTransionDelegate?
    // MARK: - Init
    init(nameViewModel: NameViewModel,
         profileListViewModel: ProfileListViewModel,
         coordinator: PorfileTransionDelegate?) {
        self.nameViewModel = nameViewModel
        self.profileListViewModel = profileListViewModel
        self.coordinator = coordinator
        
        configureSections()
        configureLayoutSections()
        bindNameChanges()
    }
}
// MARK: - Private Handler
//
extension ProfileViewModel {
    private func configureSections() {
        let nameSection = NameOfProfileCollectionViewSection(sectionName: nameViewModel.nameItem)
        let firstList = ProfileListCollectionViewSection(items: profileListViewModel.firstList,
                                                         coordinator: coordinator)
        let secondList = ProfileListCollectionViewSection(items: profileListViewModel.secondList,
                                                          coordinator: coordinator)
        sections = [nameSection, firstList, secondList]
    }
    private func configureLayoutSections() {
        let name = NameCollectionViewLayoutSection()
        let firstList = ProfileListLayoutSection()
        let secondList = ProfileListLayoutSection()
        
        layoutSections = [name, firstList, secondList]
    }
}
// MARK: - Binding
//
extension ProfileViewModel {
    private func bindNameChanges() {
        nameViewModel
            .$nameItem
            .sink { [weak self] updatedName in
                guard let self else { return }
                if let nameSection = self.sections.first as? NameOfProfileCollectionViewSection {
                    nameSection.sectionName = updatedName
                    self.sections[0] = nameSection
                }
            }
            .store(in: &cancellables)
    }
}
