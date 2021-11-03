class Pitcher < ApplicationRecord
  def self.most_winners(year)
    maximum_wins =  where(year_id: year).maximum(:wins)
    where(year_id: year, wins: maximum_wins).pluck(:player_id)
  end
end
