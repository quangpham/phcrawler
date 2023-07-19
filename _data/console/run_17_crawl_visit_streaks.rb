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




