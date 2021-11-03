class Pitcher < ApplicationRecord
  # ある年にもっとも勝利したピッチャーのplayer_idを配列で取得するメソッド
  def self.most_winners(year)
    maximum_wins = where(year_id: year).maximum(:wins)
    where(year_id: year, wins: maximum_wins).pluck(:player_id)
  end
  # ある年に勝利した順に、ピッチャー10人のplayer_idを配列で取得するメソッド
  def self.top_ten(year)
    # DIVERの答え
    pitchers = where(year_id: year).order(wins: :desc)
    if pitchers.count < 10
      best_pitchers = pitchers
    else
      tenth_win = pitchers.limit(10)[9].wins
      best_pitchers = pitchers.where("wins >= ?", tenth_win)
    end
    best_pitchers.pluck(:player_id)
  end
    # 自分で描いてみた答え
    # pitchers = where(year_id: year).order(wins: :desc)
    # if pitchers.count > 10
    #   ten_number = pitchers[9].wins
    #   top_ten_count = pitchers.where("wins >= ?", ten_number).count
    #   pitchers.limit(top_ten_count).pluck(:player_id)
    # else
    #   pitchers.limit(10).pluck(:player_id)
    # end
end
