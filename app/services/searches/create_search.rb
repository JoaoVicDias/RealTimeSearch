module Searches
    class CreateSearch
       def call(search_data)
            search_data[:content] = search_data[:content].strip

            new_search = Search.new(search_data)

            new_search.save!

            new_search
       end
    end
end