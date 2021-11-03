require 'rails_helper'

RSpec.describe Pitcher, type: :model do
  describe Pitcher do
    it "most_winnersメソッド使用時、最多勝投手が一人の場合" do
      Pitcher.create(player_id: 'taro', year_id: 2000, wins: 8)
      Pitcher.create(player_id: 'jiro', year_id: 2000, wins: 9)
      Pitcher.create(player_id: 'saburo', year_id: 2000, wins: 10)
      Pitcher.create(player_id: 'siro', year_id: 2001, wins: 10)
      expect(Pitcher.most_winners(2000)).to eq ["saburo"]
    end

    it "most_winnersメソッド使用時、最多勝投手が複数人の場合" do
      Pitcher.create(player_id: 'taro', year_id: 2000, wins: 8)
      Pitcher.create(player_id: 'jiro', year_id: 2000, wins: 10)
      Pitcher.create(player_id: 'saburo', year_id: 2000, wins: 10)
      Pitcher.create(player_id: 'siro', year_id: 2001, wins: 10)
      expect(Pitcher.most_winners(2000)).to eq ["jiro","saburo"]
    end

    it "most_winnersメソッド使用時、指定した年のデータが存在しない場合" do
      Pitcher.create(player_id: 'siro', year_id: 2001, wins: 10)
      expect(Pitcher.most_winners(2000)).to eq []
    end

    it "top_tenメソッド使用時、上から10番目の投手と同じ勝利数の投手がいない場合" do
      Pitcher.create(player_id: 'taro', year_id: 2000, wins: 15)
      Pitcher.create(player_id: 'jiro', year_id: 2000, wins: 14)
      Pitcher.create(player_id: 'saburo', year_id: 2000, wins: 13)
      Pitcher.create(player_id: 'siro', year_id: 2000, wins: 12)
      Pitcher.create(player_id: 'goro', year_id: 2000, wins: 11)
      Pitcher.create(player_id: 'rokuro', year_id: 2000, wins: 20)
      Pitcher.create(player_id: 'sitiro', year_id: 2000, wins: 19)
      Pitcher.create(player_id: 'hatiro', year_id: 2000, wins: 18)
      Pitcher.create(player_id: 'kuro', year_id: 2000, wins: 17)
      Pitcher.create(player_id: 'juro', year_id: 2000, wins: 16)
      Pitcher.create(player_id: 'juichiro', year_id: 2000, wins: 10)
      Pitcher.create(player_id: 'jujiro', year_id: 2001, wins: 18)
      expect(Pitcher.top_ten(2000)).to eq ["rokuro","sitiro","hatiro","kuro","juro","taro","jiro","saburo","siro","goro"]
    end

    it "top_tenメソッド使用時、上から10番目の投手と同じ勝利数の投手がいる場合" do
      Pitcher.create(player_id: 'taro', year_id: 2000, wins: 15)
      Pitcher.create(player_id: 'jiro', year_id: 2000, wins: 14)
      Pitcher.create(player_id: 'saburo', year_id: 2000, wins: 13)
      Pitcher.create(player_id: 'siro', year_id: 2000, wins: 12)
      Pitcher.create(player_id: 'goro', year_id: 2000, wins: 11)
      Pitcher.create(player_id: 'rokuro', year_id: 2000, wins: 20)
      Pitcher.create(player_id: 'sitiro', year_id: 2000, wins: 19)
      Pitcher.create(player_id: 'hatiro', year_id: 2000, wins: 18)
      Pitcher.create(player_id: 'kuro', year_id: 2000, wins: 17)
      Pitcher.create(player_id: 'juro', year_id: 2000, wins: 17)
      Pitcher.create(player_id: 'juichiro', year_id: 2000, wins: 11)
      Pitcher.create(player_id: 'jujiro', year_id: 2000, wins: 10)
      Pitcher.create(player_id: 'jujiro', year_id: 2001, wins: 18)
      # binding.irb
      expect(Pitcher.top_ten(2000)).to eq ["rokuro","sitiro","hatiro","juro","kuro","taro","jiro","saburo","siro","goro","juichiro"]
    end

    it "top_tenメソッド使用時、指定した年のデータが10件に満たない場合" do
      Pitcher.create(player_id: 'taro', year_id: 2000, wins: 15)
      Pitcher.create(player_id: 'jiro', year_id: 2000, wins: 14)
      Pitcher.create(player_id: 'hatiro', year_id: 2000, wins: 18)
      Pitcher.create(player_id: 'kuro', year_id: 2000, wins: 17)
      Pitcher.create(player_id: 'juro', year_id: 2000, wins: 17)
      Pitcher.create(player_id: 'juichiro', year_id: 2000, wins: 11)
      Pitcher.create(player_id: 'jujiro', year_id: 2000, wins: 10)
      Pitcher.create(player_id: 'jusaburo', year_id: 2001, wins: 18)
      expect(Pitcher.top_ten(2000)).to eq ["hatiro","kuro","juro","taro","jiro","juichiro","jujiro"]
    end

    it "top_tenメソッド使用時、指定した年のデータが存在しない場合" do
      Pitcher.create(player_id: 'jusaburo', year_id: 2001, wins: 18)
      expect(Pitcher.top_ten(2000)).to eq []
    end

    it "most_winner_in_the_teamメソッド使用時、チーム内で最多勝投手が一人の場合" do
      Pitcher.create(player_id: 'taro', year_id: 2000, team_id: 'DK1', wins: 8)
      Pitcher.create(player_id: 'jiro', year_id: 2000,team_id: 'DK1', wins: 9)
      Pitcher.create(player_id: 'saburo', year_id: 2000,team_id: 'DK1', wins: 10)
      Pitcher.create(player_id: 'siro', year_id: 2001,team_id: 'ST1', wins: 10)
      expect(Pitcher.most_winner_in_the_team(2000, 'DK1')).to eq ["saburo"]
    end

    it "most_winner_in_the_teamメソッド使用時、チーム内で最多勝投手が複数人の場合" do
      Pitcher.create(player_id: 'taro', year_id: 2000, team_id: 'DK1', wins: 8)
      Pitcher.create(player_id: 'jiro', year_id: 2000, team_id: 'DK1', wins: 10)
      Pitcher.create(player_id: 'saburo', year_id: 2000, team_id: 'DK1', wins: 10)
      Pitcher.create(player_id: 'siro', year_id: 2001, team_id: 'ST1', wins: 10)
      expect(Pitcher.most_winner_in_the_team(2000, 'DK1')).to eq ["jiro","saburo"]
    end

    it "most_winner_in_the_teamメソッド使用時、チーム内で指定した年のデータが存在しない場合" do
      Pitcher.create(player_id: 'siro', year_id: 2001, team_id: 'DK1', wins: 10)
      expect(Pitcher.most_winner_in_the_team(2000, 'DK1')).to eq []
    end
  end
end
