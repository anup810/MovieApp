//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Anup Saud on 2024-09-09.
//

import Foundation
import Combine

class MovieListViewModel{
    @Published private(set) var movives: [Movie] = []
    private let httpClient: HTTPClient
    private var cancellables: Set<AnyCancellable> =  []
    @Published var loadingComplete: Bool = false
    private var searchSubject = CurrentValueSubject<String, Never>("")
    
    init(httpClient: HTTPClient){
        self.httpClient = httpClient
        setUpSearchPublisher()
    }
    
    func  setUpSearchPublisher(){
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink {[weak self] searchText in
            self?.loadMovies(search: searchText)
        }.store(in: &cancellables)
    }
    
    func setSearch(searchText:String){
        searchSubject.send(searchText)
    }
    
    func loadMovies(search: String){
        httpClient.fetchMoives(search: search).sink { [weak self] completion in
            switch completion{
            case .finished:
                self?.loadingComplete = true
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [weak self] movives in
            self?.movives = movives
        }.store(in: &cancellables)

    }
}
