require 'rails_helper'

RSpec.describe SearchesController, type: :controller do
  describe "GET #new" do
        subject { get :new }

        it "render new template" do
            subject
            expect(response).to render_template("searches/new")
        end
    end

    describe "GET #show" do
        subject { get :show }

        it "render new template" do
            subject
            expect(response).to render_template("searches/show")
        end
    end

    describe "POST #create" do 
        subject { post :create, params:  }
        
        let(:params) {
            {
                search: {
                    content: "What is",
                }
            }
        }

        context 'when user searches are empty' do 
            it 'creates a new search with rigth data' do 
                subject
                expect(Search.last).to have_attributes(
                    content: "What is",
                    user: '0.0.0.0',
                    count: 1
                )
            end
    
            it 'creates a new search' do 
                expect { subject }.to change { Search.count }.by(1)
            end
        end
    
        context 'when there is existing user' do 
            let!(:search) { create(:search, user: '0.0.0.0') }  
        
            it 'does not create a new search' do 
                expect { subject }.to change { Search.count }.by(0)
            end
        end
    
        context 'when there is incomplete search' do 
            let!(:search) { create(:search, user: '0.0.0.0') }  
    
            let(:params) {
                {
                search: {
                    content: "What is a",
                }
            }
            }
    
            it 'creates a new search with rigth data' do 
                subject
                expect(Search.last).to have_attributes(
                    content: "What is a",
                    user: '0.0.0.0',
                    count: 1
                )
            end
    
            it 'deletes incomplete search' do 
                subject
                expect(Search.count).to eql(1)
            end
        end
    end
end