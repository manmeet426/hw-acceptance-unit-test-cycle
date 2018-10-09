require "rails_helper"

describe "MovieModel" do

    describe "movies with same director" do

        it "should find movies by the same director" do
            Movie.create(id: 1, title: "TestTitle", rating: "TestRating", description: "TestDesc", release_date: "1900", director: "TestDirector")
            Movie.create(id: 2, title: "TestTitle2", rating: "TestRating2", description: "TestDesc2", release_date: "1901", director: "TestDirector")
            movies = Movie.find_with_same_director(1)
            expect(movies.count).to eq(2)
        end
    end
end