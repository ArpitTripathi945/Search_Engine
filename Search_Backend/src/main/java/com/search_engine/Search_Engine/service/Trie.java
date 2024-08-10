package com.search_engine.Search_Engine.service;
import org.springframework.stereotype.Component;

import java.util.*;

@Component
public class Trie {

    private TrieNode root;

    public Trie() {
        root = new TrieNode();
    }

    public void insert(String word){
        TrieNode node = root;
        for(char c: word.toLowerCase().toCharArray()){
            if(c<'a' || c >'z'){
                continue;
            }
            if(!node.containsKey(c)){
                node.put(c, new TrieNode());
            }
            node = node.get(c);
            node.addWord(word);

        }
        node.setEnd();
    }

    public List<String> search(String prefix){
        TrieNode node = root;
        for(char c : prefix.toLowerCase().toCharArray()){
            if(!node.containsKey(c)){
                return new ArrayList<>();
            }
            node = node.get(c);
        }
        return new ArrayList<>(node.getWords());


    }
}
