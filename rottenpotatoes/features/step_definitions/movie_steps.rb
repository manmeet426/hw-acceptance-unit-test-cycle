Given /the following movie exist/ do |movies_table|
    movies_table.hashes.each do |movie|
        Movie.create!(movie)
    end
end

Then /I should see "(.*)" before "(.*)"/ do |movie_title1, movie_title2|
    body = page.body
    location_of_movie_title1_in_body = body.index(movie_title1)
    location_of_movie_title2_in_body = body.index(movie_title2)
    loc1 = location_of_movie_title1_in_body
    loc2 = location_of_movie_title2_in_body
    if loc1 == nil || loc2 == nil
        fail "One of both search parameters not found"
    else
        expect(loc1<loc2).to eq true
    end
end    

Then /I should see all the movies/ do
    rows = page.all("table#movies>tbody tr").count
    expect(rows).to eq Movie.count
end

Then /^ the director of "(.*)" should be "(.*)" $/ do |title_value, director_value|
    movie = Movie.find_by_title(title_value)
    expect(movie.director).to eq director_value
end