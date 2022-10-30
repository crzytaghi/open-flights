class Airline < ApplicationRecord
  has_many :reviews

  before_save :slugify

  # When we create a new airline, we will slugify or create a url safe slug
  def slugify
    # parameterize creates a url safe string, i.e. "Hello There".parameterize = hello_there
    self.slug = name.parameterize
  end

  # Get the average score of the reviews of the airline
  def avg_score
    # takes the average of the score value and rounds it to 2 places and converts it to a float value
    reviews.average(:score).round(2).to_f
  end

end
