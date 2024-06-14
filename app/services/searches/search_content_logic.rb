module Searches
    class SearchContentLogic
       def call(searches, new_content)
            new_content = new_content.delete(' ').downcase

            existing_search = nil
            searchs_to_delete = []

            searches.each do |search|
                search_content = search.content.delete(' ').downcase

                if new_content.include?(search_content)
                    if search_content.include?(new_content)
                        existing_search = search
                        
                        search.update(count: search.count + 1)

                        break
                    else
                        searchs_to_delete.push(search)
                    end

                else
                    if search_content.include?(new_content)
                        existing_search = search
                    end
                end
            end

            {
                existing_search:,
                searchs_to_delete:
            }
        end
    end
end