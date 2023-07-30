# Tao file crawl visit_streaks
# Mot lan lay duoc 100 users
# B1: crawl 1 cai dau tien de lay totalCount
# B2: totalCount/100

totalCount = 29173

commands = []
cursors[..(totalCount/100+20)].each_with_index do |cursor, i|
  commands.push "./GetVisitStreaks.sh #{cursor}"
end
slipt_commands_to_files(commands, 15, cursors)

# Import


def import_streaks json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].shuffle.each do |fn|
    begin
      data = JSON.parse(File.read(fn))
      data["data"]["visitStreaks"]["edges"].each do |d|
        n = d["node"]
        user = helper_get_user_by_node_data(n["user"])
        if n["duration"]
          user.max_streak = [user.max_streak.to_i, n["duration"]].max
        end
        user.save
      end
    rescue
    end
  end
end



def import_streaks json_path="tmp/run/tmp/"
  Dir["#{json_path}/_r.*.json".gsub("//","/")].shuffle.each do |fn|
    data = JSON.parse(File.read(fn))
    data["data"]["visitStreaks"]["edges"].each do |d|
      n = d["node"]
      user = helper_get_user_by_node_data(n["user"])
      if n["duration"]
        user.max_streak = [user.max_streak.to_i, n["duration"]].max
      end
      user.save
    end
  end
end


