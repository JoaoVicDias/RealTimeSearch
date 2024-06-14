require 'rails_helper' 
RSpec.describe Searches::SearchContentLogic, :type => :service do 
    subject { described_class.new.call(searches, new_content) }

    let(:searches) {
        Search.all
    }
     
    let(:new_content) { 'what is a' }

    let!(:search) { create(:search, content: 'what is a') }
    context 'when new content include some existing data' do 
        context 'and existing data is equal with new content' do 
            it 'returns right value' do 
                expect(subject).to include(
                    existing_search: search,
                    searchs_to_delete: []
                )
            end

            it 'increases count value for existing search' do 
                subject
                expect(search.reload.count).to eql(2)
            end
        end

        context 'and existing data is not equal with new content' do 
            let!(:search) { create(:search) }

            it 'returns rigth value' do 
                expect(subject).to include(
                    existing_search: nil,
                    searchs_to_delete: [search]
                )
            end
        end
    end

    context 'when new content does not include some existing data' do 
        let(:new_content) { 'what is' }
        
        it 'returns rigth value' do 
            expect(subject).to include(
                existing_search: search,
                searchs_to_delete: []
            )
        end
    end
end