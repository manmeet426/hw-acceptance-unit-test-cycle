require 'rails_helper'



describe MoviesController do

    describe "show selected movie" do

        it "should find movie with selected id"  do
            Movie.create(id: 1, title: "TestTitle", rating: "TestRating", description: "TestDesc", release_date: "1900")
            id_params = {id: 1}
            get :show, id_params
            expect(assigns(:movie)).to eq Movie.find(1)
        end
    end

    describe "show homepage" do

        it "should hilight title header if it is selected" do
            sort_params = {sort: 'title'}
            get :index, sort_params
            expect(assigns(:title_header)).to eq 'hilite'
        end
        it "should hilight release_date header if it is selected" do
            sort_params = {sort: 'release_date'}
            get :index, sort_params
            expect(assigns(:date_header)).to eq 'hilite'
        end
        it "should set movies list according to filters" do
            Movie.create(id: 1, title: "TestTitle", rating: "PG", description: "TestDesc", release_date: "1900")
            filter_params = {ratings: {"PG"=>"1", "PG-13"=>"1"}, sort: 'title'}
            get :index, filter_params
            #expect(assigns(:movies)).to eq Movie.where(rating: ['PG', 'PG-13']).order({:title => :asc})
            expect(assigns(:movies) == Movie.where(rating: ['PG', 'PG-13']).order({:title => :asc}))
        end
    end

    describe "create new movie" do
        it "should redirect to index page" do
            create_params = {"movie"=> {"title"=> "TestTitle", "rating"=> "TestRating", 
            "description"=> "TestDesc", "release_date"=> "1900"}}
            post :create, create_params
            expect(response).to redirect_to "/movies"
        end
    end

    describe "set edit page" do
        it "should set movie details in edit page" do
            Movie.create(id: 1, title: "TestTitle", rating: "TestRating", description: "TestDesc", release_date: "1900")
            id_params = {id: 1}
            get :edit, id_params
            expect(assigns(:movie)).to eq Movie.find 1
        end
    end

    describe "update movie" do

        it "should update movie's details" do
            Movie.create(id: 1, title: "TestTitle", rating: "TestRating", description: "TestDesc", release_date: "1900")
            update_params = {id: 1, "movie"=> {"title"=> "ChangeTitle", "rating"=> "ChangeRating", 
            "description"=> "ChangeDesc", "release_date"=> "1900"}}
            post :update, update_params
            expect(response).to redirect_to "/movies/1"
        end
    end

    describe "delete movie" do

        it "should destroy movie instance" do
            Movie.create(id: 1, title: "TestTitle", rating: "TestRating", description: "TestDesc", release_date: "1900")
            id_params = {id: 1}
            expect {
                delete :destroy, id_params}.to change(Movie, :count).by(-1)
        end
    end
    
    # describe "finding movies with same director" do

    #     it "should redirect to about page if movie has no director" do
    #         @movie = Movie.create(id: 1, title: "TestTitle", rating: "TestRating", description: "TestDesc", release_date: "1900")
    #         id_params = {id: 1}
    #         get :search_directors, id_params
    #         expect(response).to redirect_to "/movies"
    #     end

    #     it "should render movies with same director if movie has director" do
    #         @movie = Movie.create(id: 1, title: "TestTitle", rating: "TestRating", description: "TestDesc", release_date: "1900", director: "TestDirector")
    #         id_params = {id: 1}
    #         get :search_directors, id_params
    #         expect(response).to render_template :search_directors
    #     end
    # end
end