//
//  HomeSectionConfigurator.swift
//  Herfety
//
//  Created by Mahmoud Alaa on 16/08/2025.
//

import Foundation
import Combine

class HomeSectionConfigurator: HomeSectionConfiguratorProtocol {
    private var cancellables = Set<AnyCancellable>()
    
    func configureSections(
        sliderItems: [SliderItem],
        categoryItems: [CategoryElement],
        productItems: [Products],
        topBrandsItems: [TopBrandsItem],
        dailyEssentialItems: [DailyEssentialyItem],
        coordinator: HomeTranisitionProtocol
    ) -> [CollectionViewDataSource] {
        
        let sliderProvider = createSliderSection(items: sliderItems, coordinator: coordinator)
        let categoryProvider = createCategorySection(items: categoryItems, coordinator: coordinator)
        let cardProvider = createCardSection(items: productItems, coordinator: coordinator)
        let topBrandsProvider = createTopBrandsSection(items: topBrandsItems, coordinator: coordinator)
        let dailyEssentialsProvider = createDailyEssentialsSection(items: dailyEssentialItems, coordinator: coordinator)
        
        return [sliderProvider, categoryProvider, cardProvider, topBrandsProvider, dailyEssentialsProvider]
    }
    
    func configureLayoutSections() -> [LayoutSectionProvider] {
        return [
            SliderSectionLayoutProvider(),
            CategoriesSectionLayoutSection(),
            CardProductSectionLayoutProvider(),
            TopBrandsSectionLayoutProvider(),
            DailyEssentailSectionLayoutProvider()
        ]
    }
}
// MARK: - Private Section Creators
//
extension HomeSectionConfigurator {
    private func createSliderSection(items: [SliderItem], coordinator: HomeTranisitionProtocol) -> SliderCollectionViewSection {
        let provider = SliderCollectionViewSection(sliderItems: items)
        provider.selectedItem
            .sink { sliderItems in
                coordinator.goToSliderItem(discount: (sliderItems.1 + 1) * 10)
            }
            .store(in: &cancellables)
        return provider
    }
    
    private func createCategorySection(items: [CategoryElement], coordinator: HomeTranisitionProtocol) -> CategoryCollectionViewSection {
        let provider = CategoryCollectionViewSection(categoryItems: items)
        provider.categorySelection
            .sink { item in
                coordinator.goToCategoryItem(category: item.name ?? "")
            }
            .store(in: &cancellables)
        return provider
    }
    
    private func createCardSection(items: [Products], coordinator: HomeTranisitionProtocol) -> CardItemCollectionViewSection {
        let provider = CardItemCollectionViewSection(productItems: items)
        provider.headerConfigurator = { header in
            header.configure(title: "the best deal on", description: "Jewelry & Accessories", shouldShowButton: true)
        }
        provider.selectedItem
            .sink { product in
                coordinator.gotToBestDealItem(productDetails: product)
            }
            .store(in: &cancellables)
        return provider
    }
    
    private func createTopBrandsSection(items: [TopBrandsItem], coordinator: HomeTranisitionProtocol) -> TopBrandsCollectionViewSection {
        let provider = TopBrandsCollectionViewSection(topBrandsItems: items)
        provider.selectedBrand
            .sink { brand in
                coordinator.gotToTopBrandItem(discount: (brand.1 + 5) * 10)
            }
            .store(in: &cancellables)
        return provider
    }
    
    private func createDailyEssentialsSection(items: [DailyEssentialyItem], coordinator: HomeTranisitionProtocol) -> DailyEssentailCollectionViewSection {
        let provider = DailyEssentailCollectionViewSection(dailyEssentail: items)
        provider.selectedItem
            .sink { essential in
                coordinator.gotToDailyEssentialItem(discount: (essential.1 + 5) * 10)
            }
            .store(in: &cancellables)
        return provider
    }
}
