package com.search_engine.Search_Engine.service;

import java.util.HashSet;
import java.util.Set;

public class TrieNode {
    private TrieNode[] children = new TrieNode[26];
    private boolean isEndofWord = false;
    private Set<String> words = new HashSet<>();

    public TrieNode(){
        for(int i = 0; i<26; i++){
            children[i] = null;
        }

    }

    public boolean containsKey(char ch){

        if (ch < 'a' || ch > 'z') {
            return false;  // Return false for non-alphabetic characters
        }
        return children[ch - 'a'] != null;
    }

    public TrieNode get(char ch){
        return children[ch-'a'];
    }

    public void put(char ch, TrieNode node){
        children[ch-'a'] = node;
    }

    public void setEnd(){
        isEndofWord = true;
    }

    public boolean isEnd(){
        return isEndofWord;
    }

    public Set<String> getWords(){
        return words;
    }

    public void addWord(String word){
        words.add(word);
    }
}
