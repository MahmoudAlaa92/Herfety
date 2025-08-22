//
//  ProfileViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 09/02/2025.
//

import UIKit
import Combine

final class ProfileViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var profileData: ProfileData = ProfileData.empty
    @Published private(set) var sections: [CollectionViewDataSource] = []
    @Published private(set) var layoutSections: [LayoutSectionProvider] = []
    
    // MARK: - Dependencies
    private let dataSource: ProfileDataSourceProtocol
    private let sectionConfigurator: ProfileSectionConfiguratorProtocol
    private weak var coordinator: PorfileTransionDelegate?
    
    // MARK: - Properties
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(dataSource: ProfileDataSourceProtocol,
         sectionConfigurator: ProfileSectionConfiguratorProtocol,
         coordinator: PorfileTransionDelegate?) {
        self.dataSource = dataSource
        self.sectionConfigurator = sectionConfigurator
        self.coordinator = coordinator
        
        configureSectionsAndLayouts()
    }
}

// MARK: - Public Methods
extension ProfileViewModel {
    func loadProfileData() async {
        do {
            profileData = try await dataSource.fetchProfileData()
            configureSectionsAndLayouts()
        } catch {
            print("Error loading profile data: \(error)")
        }
    }
    
    func refreshProfile() async {
        await loadProfileData()
    }
}

// MARK: - Private Methods
extension ProfileViewModel {
    private func configureSectionsAndLayouts() {
        sections = sectionConfigurator.configureSections(
            profileData: profileData,
            coordinator: coordinator
        )
        
        layoutSections = sectionConfigurator.configureLayoutSections()
    }
}
