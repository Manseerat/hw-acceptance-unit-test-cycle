require 'rails_helper'

describe Movie do
    
    describe '.similar_director' do
        let!(:movie1) { FactoryBot.create(:movie, title: 'The Dark Knight', director: 'Christopher Nolan') }
        let!(:movie3) { FactoryBot.create(:movie, title: "Interstellar", director: 'Christopher Nolan') }
        let!(:movie2) { FactoryBot.create(:movie, title: 'Avengers: Infinity War', director: 'Anthony Russo') }
        let!(:movie4) { FactoryBot.create(:movie, title: "Harry Potter") }

        context 'director exists' do
            it 'finds similar movies correctly' do
                expect(Movie.similar_director(movie1.title)).to eql(['The Dark Knight', "Interstellar"])
                expect(Movie.similar_director(movie1.title)).to_not include(['Avengers: Infinity War'])
                expect(Movie.similar_director(movie2.title)).to eql(['Avengers: Infinity War'])
            end
        end

        context 'director does not exist' do
            it 'handles sad path' do
                expect(Movie.similar_director(movie4.title)).to eql(nil)
            end
        end
    end

    describe '.all_ratings' do
        it 'returns all ratings' do
            expect(Movie.all_ratings).to match(%w(G PG PG-13 NC-17 R))
        end
    end

end