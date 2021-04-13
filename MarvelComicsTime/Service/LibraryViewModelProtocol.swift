//
//  LibraryViewModel.swift
//  MarvelComicsTime
//
//  Created by Leonardo Evagelista on 06/12/20.
//

import Foundation


protocol LibraryViewModel {
    var comics:[Comic]{ get set}
    func selectComic();
}
