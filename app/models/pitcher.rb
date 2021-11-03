class Pitcher < ApplicationRecord
  # もっとも勝利したピッチャーのplayer_idを配列で取得するメソッドを共通化
  def self.get_max_win_pitchers_id(pitchers)
    maximum_wins = pitchers.maximum(:wins)
    pitchers.where(wins: maximum_wins).pluck(:player_id)
  end
  
  # ある年にもっとも勝利したピッチャーのplayer_idを配列で取得するメソッド
  def self.most_winners(year)
    pitchers = where(year_id: year)
    get_max_win_pitchers_id(pitchers)
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

    # ある年にあるチームの中でもっとも勝利したピッチャーのplayer_idを配列で取得するメソッドを記述
    def self.most_winner_in_the_team(year, team)
      pitchers = where(year_id: year, team_id: team)
      get_max_win_pitchers_id(pitchers)
    end

    # 指定された期間の中でもっとも勝利したピッチャーのplayer_idを配列で取得するメソッドを記述
    def self.most_winner_in_the_period(year_first, year_last)
      pitchers = where(year_id: year_first..year_last)
      get_max_win_pitchers_id(pitchers)
    end
end
