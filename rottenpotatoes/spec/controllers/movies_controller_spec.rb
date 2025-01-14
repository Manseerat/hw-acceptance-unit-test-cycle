require 'rails_helper'

describe MoviesController do
    describe 'Search movies by the same director' do
        it 'should call Movie\'s similar method' do
            expect(Movie).to receive(:similar_director).with('The Help')
            get :similar, { title: 'The Help' }
        end

        it 'should assign movies with same director if director exists' do
            movies = ['Chicken Run', 'The Incredibles']
            Movie.stub(:similar_director).with(movies[0]).and_return(movies)
            get :similar, { title: movies[0] }
            expect(assigns(:similar_movies)).to eql(movies)
        end

        it "should redirect to home page if no director info" do
            Movie.stub(:similar_director).with('When Harry Met Sally').and_return(nil)
            get :similar, { title: 'When Harry Met Sally' }
            expect(response).to redirect_to(root_url)
        end
    end

describe 'GET index' do
    let!(:movie) {FactoryBot.create(:movie)}

    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should assign instance variable for title header' do
      get :index, { sort: 'title'}
      expect(assigns(:title_header)).to eql('hilite')
    end

    it 'should assign instance variable for release_date header' do
      get :index, { sort: 'release_date'}
      expect(assigns(:date_header)).to eql('hilite')
    end
  end

  describe 'GET new' do
    let!(:movie) { Movie.new }

    it 'should render the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe 'POST #create' do
    it 'creates a new movie' do
      expect {post :create, movie: FactoryBot.attributes_for(:movie)
      }.to change { Movie.count }.by(1)
    end

    it 'redirects to the movie index page' do
      post :create, movie: FactoryBot.attributes_for(:movie)
      expect(response).to redirect_to(movies_url)
    end
  end

  describe 'PUT #update' do
    let(:movie1) { FactoryBot.create(:movie) }
    before(:each) do
      put :update, id: movie1.id, movie: FactoryBot.attributes_for(:movie, title: 'Modified')
    end

    it 'updates an existing movie' do
      movie1.reload
      expect(movie1.title).to eql('Modified')
    end

    it 'redirects to the movie page' do
      expect(response).to redirect_to(movie_path(movie1))
    end
  end

end