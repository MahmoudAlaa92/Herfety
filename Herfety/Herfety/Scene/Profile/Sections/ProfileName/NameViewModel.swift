//
//  NameViewModel.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 05/03/2025.
//

import UIKit
import Combine

class NameViewModel {
    @Published var nameItem: Name
    private var cancellables = Set<AnyCancellable>()

    init() {
        let shared = CustomeTabBarViewModel.shared
        self.nameItem = Name(
            name: shared.userInfo?.UserName ?? "No Name",
            email: shared.userInfo?.Email ?? "MahmoudAlaa.Wr@gmail.com",
            image: shared.userProfileImage
        )

        shared.$userProfileImage
            .receive(on: RunLoop.main)
            .sink { [weak self] newImage in
                guard let self else { return }
                self.nameItem = Name(
                    name: shared.userInfo?.UserName ?? "No Name",
                    email: shared.userInfo?.Email ?? "MahmoudAlaa.Wr@gmail.com",
                    image: newImage
                )
            }
            .store(in: &cancellables)
    }
}
