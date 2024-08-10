package com.search_engine.Search_Engine.Controller;

import com.search_engine.Search_Engine.entity.DictionaryWord;
import com.search_engine.Search_Engine.service.Trie;
import com.search_engine.Search_Engine.repository.DictionaryWordRepository;
import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/words")
public class DictionaryController {

    @Autowired
    private Trie trie;

    @Autowired
    private DictionaryWordRepository repository;

    @PostConstruct
    public void init() {
        List<String> words = repository.findAll().stream().map(DictionaryWord::getWord).collect(Collectors.toList());
        for(String word : words) {
            trie.insert(word);
        }
    }

    @GetMapping
    public List<DictionaryWord> getAllWords(){
        return repository.findAll();
    }

    @GetMapping("/search")
    public List<String> searchWords(@RequestParam String query){
        return trie.search(query);
    }
}
