require 'minitest_helper'

class TestBeerListResponse < Minitest::Test
  include PunkyBrewster

  def response
    VCR.use_cassette("whats-pouring-2015-04-26") do
      BeerListRequest.new.response
    end
  end

  def test_returns_all_beers
    assert_equal 19, response.beers.length
  end

  def test_beer_properties
    beer = response.beers.first
    assert_equal 'EPIC PALE ALE', beer.name
    assert_equal 14.00, beer.price
    assert_equal 5.4, beer.abv
    expected_image_url = 'http://www.punkybrewster.co.nz/uploads/3/7/6/2/37625085/7550425.jpg?74'
    assert_equal expected_image_url, beer.image_url
  end
end
