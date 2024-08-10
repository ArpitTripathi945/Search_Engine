package com.search_engine.Search_Engine.repository;


import com.fasterxml.jackson.annotation.JsonTypeId;
import com.search_engine.Search_Engine.entity.DictionaryWord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Component;

import javax.annotation.processing.Generated;
import java.util.List;

@Component

public interface DictionaryWordRepository extends JpaRepository<DictionaryWord, Long> {
    List<DictionaryWord> findByWordContaining(String keyword);
}
