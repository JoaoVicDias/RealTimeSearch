require 'rails_helper' 
RSpec.describe Searches::CreateSearch, :type => :service do 
    subject { described_class.new.call(search_data) }

    let(:search_data) {
        {
            content: "What is",
            user: '123.456.789',
            count: 1

        }
    }

    it 'creates a new search with rigth data' do 
        expect(subject).to have_attributes(
            content: "What is",
            user: '123.456.789',
            count: 1
        )
    end

    it 'creates a new search' do 
        expect { subject }.to change { Search.count }.by(1)
    end
end