require 'rails_helper' 
RSpec.describe Searches::Facades::CreationPipeline, :type => :service do 
    subject { described_class.new(search_data).call }

    let(:search_data) {
        {
            content: "What is",
            user: '123.456.789',
            count: 1

        }
    }

    context 'when user searches are empty' do 
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

    context 'when there is existing user' do 
        let!(:search) { create(:search) }  
    
        it 'does not create a new search' do 
            expect { subject }.to change { Search.count }.by(0)
        end
    end

    context 'when there is incomplete search' do 
        let!(:search) { create(:search) }  

        let(:search_data) {
            {
                content: "What is a",
                user: '123.456.789',
                count: 1
    
            }
        }

        it 'creates a new search with rigth data' do 
            subject
            expect(Search.last).to have_attributes(
                content: "What is a",
                user: '123.456.789',
                count: 1
            )
        end

        it 'deletes incomplete search' do 
            subject
            expect(Search.count).to eql(1)
        end
    end
     
end