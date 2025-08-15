//
//  NameViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/03/2025.
//

import Combine
import UIKit

class NameViewModel {
    // MARK: - Properties
    @Published var nameItem: Name
    ///
    private var cancellables = Set<AnyCancellable>()
    // MARK: - Init
    init() {
        nameItem = Name(name: "",
                        email: "",
                        image: Images.iconPersonalDetails)
        Task {
            await getInfo()
        }
    }
}
// MARK: - private Handler
//
private extension NameViewModel {
    func getInfo() async {
        let info = await DataStore.shared.getUserInfo()
        let userImage = await DataStore.shared.getUserProfileImage()
        self.nameItem = Name(
            name: info?.UserName ?? "",
            email: info?.Email ?? "",
            image: userImage
        )
    }
}
