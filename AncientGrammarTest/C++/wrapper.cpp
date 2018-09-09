//
//  wrapper.cpp
//  AncientGrammarTest
//
//  Created by Atto Allas on 09/09/2018.
//  Copyright © 2018 Atto Allas. All rights reserved.
//

#include <string>
#include <iostream>

#include <AncientGrammar/verb.h>
#include <AncientGrammar/utils.h>

extern "C" {
    // General free function
    void free_pointer(void* pointer) {
        free(pointer);
    }
    
    // Calculate Augment function
    const char* verb_calculate_augment(const char* stem, const bool uncommonEpsilon, const char *preposition) {
        std::string* prepositionPointer;
        if (preposition == nullptr) {
            prepositionPointer = nullptr;
        } else {
            std::string prepositionString(preposition);
            prepositionPointer = &prepositionString;
        }
        return strdup(ancientgrammar::verbs::Verb::calculateAugment(stem, uncommonEpsilon, prepositionPointer).c_str());
    }
    
    bool utils_is_vowel(const char* character) {
        return ancientgrammar::utils::isVowel(character);
    }
}
