module Searches
    module Facades
        class CreationPipeline
            def initialize(search_data)
                @search_data = search_data
            end

            def call
                return create_search if user_searches.empty?

                result = SearchContentLogic.new.call(user_searches, @search_data[:content])

                return if result[:existing_search].present?

                result[:searchs_to_delete].map{ |search| search.destroy }

                create_search
            end
            
            private

            def create_search
                CreateSearch.new.call(@search_data)
            end

            def user_searches
                @user_searches ||= Search.where(
                    user: @search_data[:user]
                ).to_a
            end
        end
    end
end